import 'package:flutter/material.dart';
import 'package:rehberlik/views/student/student_base/student_base_view.dart';

class StudentDashboardView extends StudentBaseView {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const Text('İçerik');

  @override
  Widget get secondView => const Text('Menü');
}
