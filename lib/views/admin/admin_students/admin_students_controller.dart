import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/repository/student_repository.dart';

class AdminStudentsController extends GetxController {
  final _box = GetStorage();
  final _studentRepository = Get.put(StudentRepository());
  Rxn<List<StudentWithClass>> studentWithClassList =
      Rxn<List<StudentWithClass>>();

  var selectedIndex = 0.obs;

  void getAllStudentWithClass() async {
    final schoolID = _box.read("schoolID");

    var _studentWithClassList =
        await _studentRepository.getStudentWithClass(schoolID: schoolID);

    studentWithClassList.value = _studentWithClassList;
  }
}
