import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_base_controller.dart';
import 'package:rehberlik/views/admin/admin_students/admin_students_controller.dart';

class AdminStudentDetailController extends AdminBaseController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final studentController = Get.put(AdminStudentsController());

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
