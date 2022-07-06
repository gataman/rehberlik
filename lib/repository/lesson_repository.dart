import 'package:get/get.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/services/lesson_service.dart';

class LessonRepository implements LessonService {
  final LessonService _service = Get.put(LessonService());

  @override
  Future<String> add({required Lesson object}) => _service.add(object: object);

  @override
  Future<void> delete({required String objectID}) =>
      _service.delete(objectID: objectID);

  @override
  Future<void> update({required Lesson object}) =>
      _service.update(object: object);

  @override
  Future<List<Lesson>> getAll(
          {required String classID, Map<String, dynamic>? filters}) =>
      _service.getAll(classID: classID, filters: filters);

  @override
  Future<void> addAll({required List<Lesson> list}) =>
      _service.addAll(list: list);

  @override
  Future<void> addWithClassLevel(
          {required String schoolID,
          required Lesson lesson,
          required int classLevel}) =>
      _service.addWithClassLevel(
          schoolID: schoolID, lesson: lesson, classLevel: classLevel);

  @override
  Future<void> updateWithClassLevel(
          {required Lesson lesson,
          required Lesson oldLesson,
          required int classLevel}) =>
      _service.updateWithClassLevel(
          lesson: lesson, oldLesson: oldLesson, classLevel: classLevel);
}
