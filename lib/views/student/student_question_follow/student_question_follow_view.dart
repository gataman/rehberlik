import 'package:flutter/material.dart';
import 'package:rehberlik/views/admin/admin_student_detail/components/student_detail_tab_view/question_follow/question_follow_list_card.dart';
import '../../../common/constants.dart';
import '../../../core/widgets/containers/app_list_box_container.dart';
import '../../../core/widgets/text/app_box_title.dart';
import '../../../models/student.dart';
import '../../admin/admin_student_detail/admin_student_detail_view.dart';
import '../student_base/student_base_view.dart';

class StudentQuestionFollowView extends StudentBaseView {
  const StudentQuestionFollowView({Key? key}) : super(key: key);

  @override
  Widget get firstView => QuestionFollowContainer();

  @override
  Widget get secondView => StudentInfoContainer();
}

class QuestionFollowContainer extends StatelessWidget {
  QuestionFollowContainer({Key? key}) : super(key: key);
  final student = Student.getStudentFormLocal();

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(
        child: Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Column(
        children: [
          const AppBoxTitle(title: 'Soru Takip Çizelgesi', isBack: false),
          QuestionFollowListCard(
            studentID: student!.id!,
            isStudent: true,
          ),
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
