import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/locator.dart';
import '../models/classes.dart';
import '../services/classes_service.dart';

class ClassesRepository implements ClassesService {
  final ClassesService _service = locator<ClassesService>();

  @override
  Future<String> add({required Classes object}) => _service.add(object: object);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<void> update({required Classes object}) => _service.update(object: object);

  @override
  Future<List<Classes>> getAll({Map<String, dynamic>? filters}) => _service.getAll(filters: filters);

  @override
  Future<void> addAll({required List<Classes> list}) => _service.addAll(list: list);

  @override
  Stream<QuerySnapshot<Classes?>> getAllWithStream({required String schoolID, Map<String, dynamic>? filters}) =>
      _service.getAllWithStream(schoolID: schoolID);

  @override
  Future<Classes?> get({required String classID}) => _service.get(classID: classID);
}
