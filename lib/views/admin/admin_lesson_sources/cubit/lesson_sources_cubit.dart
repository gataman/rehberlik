import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rehberlik/common/locator.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:rehberlik/models/lesson_source.dart';
import 'package:rehberlik/repository/lesson_source_repository.dart';

import '../../../../models/student.dart';

part 'lesson_sources_state.dart';

class LessonSourcesCubit extends Cubit<LessonSourcesState> {
  LessonSourcesCubit() : super(StudentLessonSourcesLoadingState());
  final _lessonSourceRepository = locator<LessonSourceRepository>();

  Student? selectedStudent;
  List<LessonWithSubject>? lessonSubjectList;

  void selectStudent(Student? student, Map<int, List<LessonWithSubject>>? lessonList) {
    if (student == null) {
      selectedStudent = null;
      _loadingState();
    } else {
      selectedStudent = student;
      _getStudentLessonSourcesDetail(student, lessonList);
    }
  }

  void _loadingState() {
    emit(StudentLessonSourcesLoadingState());
  }

  Future<void> _getStudentLessonSourcesDetail(Student student, Map<int, List<LessonWithSubject>>? lessonList) async {
    List<Map<String, dynamic>> mapList = [];

    if (selectedStudent != null) {
      if (lessonList != null) {
        final lesList = lessonList[student.classLevel!];
        final resourcesList = await _lessonSourceRepository.getAll(filters: {'studentId': selectedStudent!.id});

        if (lesList != null) {
          for (var lessonWithSubject in lesList) {
            List<LessonSource>? lessonResourceList;
            if (resourcesList != null) {
              lessonResourceList =
                  resourcesList.where((element) => element.lessonId == lessonWithSubject.lesson.id).toList();
            }
            Map<String, dynamic> lessonMap = {
              'lessonWithSubject': lessonWithSubject,
              'lessonResourceList': lessonResourceList
            };
            mapList.add(lessonMap);
          }
        }
      }
      // İlgili öğrencinin sınıf seviyesine göre derslerin ve konuların listesini al
      // Öğrencinin kaynak detayını getir
      // Kaynak detayına göre konu idsini karşılaştır ve Derse göre listele bu listeyi de emitle:

      // if (list != null) {
      //   for (var lessonSource in list) {
      //     if (lessonSource.subjectList != null) {
      //       for (var subjectId in lessonSource.subjectList!) {
      //         var id = subjectId;
      //         if (id is String) {
      //           debugPrint(id);
      //         }
      //       }
      //     }
      //   }
      // }

      emit(StudentLessonSourcesSelectedStade(student: selectedStudent!, mapList: mapList));
    }
  }

  void saveStudentResources({required LessonSource lessonSource}) {
    _lessonSourceRepository
        .add(object: lessonSource)
        .then((value) => debugPrint(value.toString()))
        .onError((error, stackTrace) => debugPrint(error.toString()));
  }
}
