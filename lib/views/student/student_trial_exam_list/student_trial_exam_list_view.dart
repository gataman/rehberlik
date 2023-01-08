import 'package:flutter/src/widgets/framework.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_imports.dart';
import 'package:rehberlik/views/student/student_base/student_base_view.dart';
import 'package:rehberlik/views/student/student_trial_exam_list/cubit/components/student_trial_exam_list_card.dart';

class StudentTrialExamListView extends StudentBaseView {
  const StudentTrialExamListView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const StudentTrialExamListCard();

  @override
  Widget get secondView => const Text('Second');

  @override
  bool get isFullPage => true;
}
