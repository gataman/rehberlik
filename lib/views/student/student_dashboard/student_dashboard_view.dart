import 'package:flutter/material.dart';
import '../../../common/constants.dart';
import '../../../core/widgets/containers/app_list_box_container.dart';
import '../../../core/widgets/text/app_box_title.dart';
import '../../../models/student.dart';
import '../../admin/admin_student_detail/components/student_detail_tab_view/time_table/student_time_table_card.dart';
import '../../admin/admin_student_detail/components/student_info_card.dart';
import '../student_base/student_base_view.dart';

class StudentDashboardView extends StudentBaseView {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  Widget get firstView => TimeTableContainer();

  @override
  Widget get secondView => StudentInfoContainer();
}

class TimeTableContainer extends StatelessWidget {
  TimeTableContainer({Key? key}) : super(key: key);
  final student = Student.getStudentFormLocal();

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(
        child: Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Column(
        children: [
          const AppBoxTitle(title: 'Haftalık Çalışma Programım', isBack: false),
          StudentTimeTableCard(student: student!),
        ],
      ),
    ));
  }
}

class StudentInfoContainer extends StatelessWidget {
  StudentInfoContainer({Key? key}) : super(key: key);
  final student = Student.getStudentFormLocal();

  @override
  Widget build(BuildContext context) {
    return StudentInfoCard(
      student: student,
    );
  }
}
