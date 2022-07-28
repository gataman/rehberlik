import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_view.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_student_detail_view.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_students_view.dart';
import 'package:rehberlik/views/admin/admin_lessons/admin_lessons_view.dart';
import 'package:rehberlik/views/admin/admin_uploads/admin_uploads_view.dart';
import 'package:rehberlik/views/admin/dashboard/admin_dashboard_view.dart';

class AdminViewController extends GetxController {
  var selectedMenuItemIndex = 0.obs;
  final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

  //getters
  GlobalKey<ScaffoldState> get scaffoldStateKey => _scaffoldStateKey;

  //functions
  void selectMenuItem(int index) {
    selectedMenuItemIndex.value = index;
    update();
  }

  void controlMenu() {
    if (!_scaffoldStateKey.currentState!.isDrawerOpen) {
      _scaffoldStateKey.currentState!.openDrawer();
    }
  }

  Widget getSelectedView() {
    final list = <Widget>[
      AdminDashboardView(),
      const AdminClassesView(),
      const AdminStudentsView(),
      const AdminLessonsView(),
      const Center(child: Text("ÇALIŞMA PROGRAMI")),
      const Center(child: Text("RANDEVULAR")),
      const Center(child: Text("MESAJLAR")),
      const AdminUploadsView(),
      const AdminStudentDetailView(),
    ];

    return list[selectedMenuItemIndex.value];
  }
}
