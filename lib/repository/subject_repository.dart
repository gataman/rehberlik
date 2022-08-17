import 'package:get/get.dart';
import 'package:rehberlik/models/subject.dart';
import 'package:rehberlik/services/subject_service.dart';

class SubjectRepository implements SubjectService {
  final SubjectService _service = Get.put(SubjectService());

  @override
  Future<String> add({required Subject object}) => _service.add(object: object);

  @override
  Future<void> addAll({required List<Subject> list}) =>
      _service.addAll(list: list);

  @override
  Future<void> delete({required String objectID}) =>
      _service.delete(objectID: objectID);

  @override
  Future<List<Subject>?> getAll(
          {required String lessonID, Map<String, dynamic>? filters}) =>
      _service.getAll(lessonID: lessonID);

  @override
  Future<void> update({required Subject object}) =>
      _service.update(object: object);

  @override
  Future<void> deleteWithLessonID(
          {required String objectID, required String lessonID}) =>
      _service.deleteWithLessonID(objectID: objectID, lessonID: lessonID);
}
