import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../models/helpers/lesson_with_subject.dart';

import '../../../../../../common/extensions.dart';
import '../../../../../../common/locator.dart';
import '../../../../../../models/lesson.dart';
import '../../../../../../repository/lesson_repository.dart';

part 'lesson_list_state.dart';

class LessonListCubit extends Cubit<LessonListState> {
  LessonListCubit() : super(LessonListState(selectedCategory: 8));
  final _lessonsRepository = locator<LessonRepository>();

  Map<int, List<LessonWithSubject>>? lessonList;
  int selectedCategory = 8;

  void fetchLessonList() async {
    if (lessonList == null) {
      _lessonsRepository.getAllWithSubjects().then((list) {
        final lastList = list.groupBy((lessonWithSubject) => lessonWithSubject.lesson.classLevel);
        final sortedList = SplayTreeMap<int, List<LessonWithSubject>>.from(lastList, (a, b) => a.compareTo(b));

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

  Future<String> addLesson(LessonWithSubject lessonWithSubject) async {
    final lessonID = await _lessonsRepository.add(object: lessonWithSubject.lesson);
    lessonWithSubject.lesson.id = lessonID;
    _addLessonInLocalList(lessonWithSubject);

    return lessonID;
  }

  Future<void> updateLesson(Lesson lesson, int oldClass) async {
    return _lessonsRepository.update(object: lesson).then((value) {
      //_updateLessonInLocalList(lesson: lesson, oldClass: oldClass);
      _refreshList();
    });
  }

  Future<void> deleteLesson({required LessonWithSubject lessonWithSubject}) async {
    return _lessonsRepository.delete(objectID: lessonWithSubject.lesson.id!).whenComplete(() {
      // editingLesson.value = null;
      _deleteLessonInLocalList(lessonWithSubject: lessonWithSubject);
    });
  }

  void _deleteLessonInLocalList({required LessonWithSubject lessonWithSubject}) {
    lessonList![lessonWithSubject.lesson.classLevel]!.remove(lessonWithSubject);
    _refreshList();
  }

  void _addLessonInLocalList(LessonWithSubject lessonWithSubject) {
    if (lessonList == null) {
      var map = <int, List<LessonWithSubject>>{
        lessonWithSubject.lesson.classLevel!: <LessonWithSubject>[lessonWithSubject]
      };
      lessonList = map;
    } else {
      // Bu sınıf seviyesinde henüz ders yoksa
      if (lessonList![lessonWithSubject.lesson.classLevel!] == null) {
        lessonList![lessonWithSubject.lesson.classLevel!] = <LessonWithSubject>[lessonWithSubject];
      } else {
        // Ders varsa
        lessonList![lessonWithSubject.lesson.classLevel!]!.add(lessonWithSubject);
      }
    }

    emit(LessonListState(selectedCategory: selectedCategory, lessonList: lessonList, isLoading: false));
  }

  void _refreshList() {
    emit(LessonListState(selectedCategory: selectedCategory, lessonList: lessonList, isLoading: false));
  }
}
