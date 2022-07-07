import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/repository/lesson_repository.dart';

class AdminLessonsController extends GetxController {
  final _lessonsRepository = Get.put(LessonRepository());

  Rxn<Map<int, List<Lesson>>> lessonList = Rxn<Map<int, List<Lesson>>>();
  var selectedIndex = 2.obs;

  var statusAddingLesson = false.obs;
  var statusOpeningDialog = false.obs;

  final editingLesson = Rxn<Lesson>();

  void getAllLessonList() async {
    debugPrint("getAllLessonList çağrıldı");
    _lessonsRepository.getAll().then((_lessonList) {
      final lastList = _lessonList.groupBy((lesson) => lesson.classLevel);
      final sortedList = SplayTreeMap<int, List<Lesson>>.from(
          lastList, (a, b) => a.compareTo(b));

      lessonList.value = sortedList;
    });
  }

  void addLesson(Lesson lesson) async {
    _lessonsRepository.add(object: lesson).then((value) {});
  }

  void updateLesson(Lesson lesson) async {
    _lessonsRepository.update(object: lesson);
  }
}
