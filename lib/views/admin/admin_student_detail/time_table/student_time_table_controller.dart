import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:rehberlik/repository/classes_repository.dart';
import 'package:rehberlik/repository/lesson_repository.dart';
import 'package:rehberlik/repository/time_table_repository.dart';

class StudentTimeTableController extends GetxController {
  //region Properties
  final _timeTableRepository = Get.put(TimeTableRepository());
  final _lessonRepository = Get.put(LessonRepository());
  final _classRepository = Get.put(ClassesRepository());

  Rxn<Map<int, List<TimeTable>>> timeTableList =
      Rxn<Map<int, List<TimeTable>>>();
  final Rxn<TimeTable> selectedTimeTable = Rxn<TimeTable>();

  final selectedClassLevel = 0.obs;
  var needUpdate = false;
  final RxList<LessonWithSubject> lessonWithSubjectList =
      RxList<LessonWithSubject>();
  final Rxn<LessonWithSubject> selectedLesson = Rxn<LessonWithSubject>();

  //endregion

//region TimeTable
  Future<Map<int, List<TimeTable>>?> getAllTimeTable(
      {required Student student}) async {
    return await Future.delayed(const Duration(milliseconds: 1), () async {
      final _localList = <TimeTable>[];

      for (var order = 0; order < 4; order++) {
        for (var day = 1; day <= 7; day++) {
          var timeTable =
              TimeTable(studentID: student.id, order: order, day: day);

          _localList.add(timeTable);
        }
      }

      final remoteList =
          await _timeTableRepository.getAll(filters: {'studentID': student.id});

      if (remoteList != null && remoteList.isNotEmpty) {
        for (var _timeTable in remoteList) {
          var findingTimeTable = _localList.firstWhereOrNull((element) =>
              element.day == _timeTable.day &&
              element.order == _timeTable.order);
          if (findingTimeTable != null) {
            final index = _localList.indexOf(findingTimeTable);
            _localList[index] = _timeTable;
          }
        }
      }

      await getAllLessonWithSubject(student: student);
      final groupedList = _localList.groupBy((element) => element.order);
      timeTableList.value = groupedList;
      timeTableList.refresh();

      return groupedList;
    });
  }

  Future<void> getAllLessonWithSubject({required Student student}) async {
    if (student.classID != null) {
      final classes = await _classRepository.get(classID: student.classID!);
      if (classes != null) {
        if (needUpdate) {
          await getAndUpdateList(classes);
          needUpdate = false;
        } else {
          if (selectedClassLevel.value != classes.classLevel) {
            await getAndUpdateList(classes);
          } else {
            debugPrint("Yeni ders listesi yüklemeye gerek yok........");
          }
        }
      }
    }
  }

  Future<void> getAndUpdateList(Classes classes) async {
    final _lessonWithSubjectList = await _lessonRepository
        .getAllWithSubjects(filters: {'classLevel': classes.classLevel});

    lessonWithSubjectList.value = _lessonWithSubjectList;
    if (classes.classLevel != null) {
      selectedClassLevel.value = classes.classLevel!;
    }
  }

  Future<String?> addTimeTable({required TimeTable timeTable}) async {
    return _timeTableRepository.add(object: timeTable);
  }

  Future<void> updateTimeTable({required TimeTable timeTable}) =>
      _timeTableRepository.update(object: timeTable);

//endregion

}
