import 'package:get/get.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
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
  Future<List<Lesson>> getAll({Map<String, dynamic>? filters}) =>
      _service.getAll(filters: filters);

  @override
  Future<void> addAll({required List<Lesson> list}) =>
      _service.addAll(list: list);

  @override
  Future<List<LessonWithSubject>> getAllWithSubjects(
          {Map<String, dynamic>? filters}) =>
      _service.getAllWithSubjects(filters: filters);
}
