import 'package:get/get.dart';
import 'package:rehberlik/models/school.dart';
import 'package:rehberlik/services/schools_service.dart';

class SchoolRepository implements SchoolService {
  final SchoolService _service = Get.put(SchoolService());

  @override
  Future<String> add({required School object}) => _service.add(object: object);

  @override
  Future<void> delete({required String objectID}) =>
      _service.delete(objectID: objectID);

  @override
  Future<void> update({required School object}) =>
      _service.update(object: object);

  @override
  Future<List<School>> getAll({Map<String, dynamic>? filters}) =>
      _service.getAll(filters: filters);

  @override
  Future<void> addAll({required List<School> list}) =>
      _service.addAll(list: list);

  @override
  Future<int> getStudentCount(
          {required String schoolID,
          required int classLevel,
          Map<String, dynamic>? filters}) =>
      _service.getStudentCount(schoolID: schoolID, classLevel: classLevel);
}
