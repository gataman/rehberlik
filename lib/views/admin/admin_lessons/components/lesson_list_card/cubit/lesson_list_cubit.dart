import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../../common/extensions.dart';
import '../../../../../../common/locator.dart';
import '../../../../../../models/lesson.dart';
import '../../../../../../repository/lesson_repository.dart';

part 'lesson_list_state.dart';

class LessonListCubit extends Cubit<LessonListState> {
  LessonListCubit() : super(LessonListState(selectedCategory: 5));
  final _lessonsRepository = locator<LessonRepository>();

  Map<int, List<Lesson>>? lessonList;
  int selectedCategory = 8;

  void fetchLessonList() async {
    if (lessonList == null) {
      _lessonsRepository.getAll().then((_lessonList) {
        final lastList = _lessonList.groupBy((lesson) => lesson.classLevel);
        final sortedList = SplayTreeMap<int, List<Lesson>>.from(lastList, (a, b) => a.compareTo(b));

        lessonList = sortedList;
        _refreshList();
      });
    } else {
      _refreshList();
    }
  }

  void changeCategory(int category) {
    selectedCategory = category;
    fetchLessonList();
  }

  Future<String> addLesson(Lesson lesson) async {
    final lessonID = await _lessonsRepository.add(object: lesson);
    lesson.id = lessonID;
    _addLessonInLocalList(lesson);

    return lessonID;
  }

  Future<void> updateLesson(Lesson lesson, int oldClass) async {
    return _lessonsRepository.update(object: lesson).then((value) {
      //_updateLessonInLocalList(lesson: lesson, oldClass: oldClass);
      _refreshList();
    });
  }

  Future<void> deleteLesson({required Lesson lesson}) async {
    return _lessonsRepository.delete(objectID: lesson.id!).whenComplete(() {
      // editingLesson.value = null;
      _deleteLessonInLocalList(lesson: lesson);
    });
  }

  void _deleteLessonInLocalList({required Lesson lesson}) {
    lessonList![lesson.classLevel]!.remove(lesson);
    _refreshList();
  }

  void _addLessonInLocalList(Lesson lesson) {
    if (lessonList == null) {
      var map = <int, List<Lesson>>{
        lesson.classLevel!: <Lesson>[lesson]
      };
      lessonList = map;
    } else {
      // Bu sınıf seviyesinde henüz ders yoksa
      if (lessonList![lesson.classLevel!] == null) {
        lessonList![lesson.classLevel!] = <Lesson>[lesson];
      } else {
        // Ders varsa
        lessonList![lesson.classLevel!]!.add(lesson);
      }
    }

    emit(LessonListState(
        selectedCategory: selectedCategory, lessonList: lessonList![selectedCategory], isLoading: false));
  }

  void _refreshList() {
    emit(LessonListState(
        selectedCategory: selectedCategory, lessonList: lessonList![selectedCategory], isLoading: false));
  }
}
