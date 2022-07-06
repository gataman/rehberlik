import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/services/classes_service.dart';

class ClassesRepository implements ClassesService {
  final ClassesService _service = Get.put(ClassesService());

  @override
  Future<String> add({required Classes object}) => _service.add(object: object);

  @override
  Future<void> delete({required String objectID}) =>
      _service.delete(objectID: objectID);

  @override
  Future<void> update({required Classes object}) =>
      _service.update(object: object);

  @override
  Future<List<Classes>> getAll(
          {required String schoolID, Map<String, dynamic>? filters}) =>
      _service.getAll(schoolID: schoolID, filters: filters);

  @override
  Future<void> addAll({required List<Classes> list}) =>
      _service.addAll(list: list);

  @override
  Stream<QuerySnapshot<Classes?>> getAllWithStream(
          {required String schoolID, Map<String, dynamic>? filters}) =>
      _service.getAllWithStream(schoolID: schoolID);
}
