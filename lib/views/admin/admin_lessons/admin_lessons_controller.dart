import 'dart:collection';
import 'package:get/get.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/repository/lesson_repository.dart';
import 'package:rehberlik/views/admin/admin_base_controller.dart';

class AdminLessonsController extends AdminBaseController {
  final _lessonsRepository = Get.put(LessonRepository());

  Rxn<Map<int, List<Lesson>>> lessonList = Rxn<Map<int, List<Lesson>>>();
  var selectedIndex = 0.obs;

  var statusAddingLesson = false.obs;
  var statusOpeningDialog = false.obs;

  final editingLesson = Rxn<Lesson>();

  void getAllLessonList() async {
    _lessonsRepository.getAll().then((_lessonList) {
      final lastList = _lessonList.groupBy((lesson) => lesson.classLevel);
      final sortedList = SplayTreeMap<int, List<Lesson>>.from(
          lastList, (a, b) => a.compareTo(b));

      lessonList.value = sortedList;
    });
  }

  void addLesson(Lesson lesson) async {
    _lessonsRepository.add(object: lesson).then((lessonID) {
      lesson.id = lessonID;
      _addLessonInLocalList(lesson);
    });
  }

  void updateLesson(Lesson lesson, int oldClass) async {
    _lessonsRepository.update(object: lesson).then((value) {
      editingLesson.value = null;
      _updateLessonInLocalList(lesson: lesson, oldClass: oldClass);
      update();
    });
  }

  void deleteLesson(Lesson lesson) {
    _lessonsRepository.delete(objectID: lesson.id!).whenComplete(() {
      editingLesson.value = null;
      _deleteLessonInLocalList(lesson: lesson);
      update();
    });
  }

  void _addLessonInLocalList(Lesson lesson) {
    if (lessonList.value == null) {
      var map = <int, List<Lesson>>{
        lesson.classLevel!: <Lesson>[lesson]
      };
      lessonList.value = map;
    } else {
      // Bu sınıf seviyesinde henüz ders yoksa
      if (lessonList.value![lesson.classLevel!] == null) {
        lessonList.value![lesson.classLevel!] = <Lesson>[lesson];
      } else {
        // Ders varsa
        lessonList.value![lesson.classLevel!]!.add(lesson);
      }
    }
    lessonList.refresh();
  }

  void _updateLessonInLocalList(
      {required Lesson lesson, required int oldClass}) {
    if (lesson.classLevel != oldClass) {
      var _lessonList = lessonList.value;
      _lessonList![oldClass]!.remove(lesson);
      _lessonList[lesson.classLevel]!.add(lesson);
      lessonList.refresh();
    } else {
      lessonList.refresh();
    }
  }

  void _deleteLessonInLocalList({required Lesson lesson}) {
    var _lessonList = lessonList.value;
    _lessonList![lesson.classLevel]!.remove(lesson);
    lessonList.refresh();
  }
}
