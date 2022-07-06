import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/models/school.dart';
import 'package:rehberlik/repository/school_repository.dart';

class HomeViewModel with ChangeNotifier implements SchoolRepository {
  final SchoolRepository _repository = Get.put(SchoolRepository());

  @override
  Future<String> add({required School object}) =>
      _repository.add(object: object);

  @override
  Future<void> addAll({required List<School> list}) =>
      _repository.addAll(list: list);

  @override
  Future<void> delete({required String objectID}) =>
      _repository.delete(objectID: objectID);

  @override
  Future<List<School>> getAll({Map<String, dynamic>? filters}) =>
      _repository.getAll(filters: filters);

  @override
  Future<void> update({required School object}) =>
      _repository.update(object: object);
}
