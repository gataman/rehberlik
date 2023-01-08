import 'package:flutter/material.dart';
import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/views/student/student_base/student_base_view.dart';
import 'package:rehberlik/views/student/student_trial_exam_detail/components/exam_detail_card.dart';

class StudentExamDetailView extends StudentBaseView {
  const StudentExamDetailView({required this.trialExam, Key? key}) : super(key: key);
  final TrialExam trialExam;

  @override
  Widget get firstView => ExamDetailCard(trialExam: trialExam);

  @override
  Widget get secondView => Container();

  @override
  bool get isFullPage => true;

  @override
  bool get isBack => true;
}
