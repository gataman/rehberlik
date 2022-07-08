import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';

class StudentDetailBox extends StatelessWidget {
  StudentDetailBox({Key? key}) : super(key: key);
  final _controller = Get.put(AdminClassesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final student = _controller.selectedStudent.value;
      if (student != null) {
        return Container(
          decoration: defaultBoxDecoration,
          child: Column(
            children: [],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
