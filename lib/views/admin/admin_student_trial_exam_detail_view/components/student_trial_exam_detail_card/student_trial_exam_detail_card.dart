import 'package:flutter/material.dart';
import '../../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';

import '../../../../../common/constants.dart';
import '../../../../../models/helpers/trial_exam_average_helper.dart';
import '../../../../../models/student.dart';
import '../../../../../models/trial_exam_result.dart';
import '../../../../../models/trial_exam_student_result.dart';
import 'student_exam_averages_widget.dart';
import 'student_exam_info_widget.dart';
import 'student_exam_line_graphics_widget.dart';
import 'student_exam_result_list_widget.dart';

class StudentTrialExamDetailCard extends StatelessWidget {
  const StudentTrialExamDetailCard(
      {Key? key,
      required this.student,
      required this.studentTrialExamResultList,
      required this.trialExamStudentResult,
      required this.classAverages,
      required this.schoolAverages,
      required this.studentTrialExamGraphList,
      required this.totalNetGraph})
      : super(key: key);

  final Student student;
  final List<TrialExamResult> studentTrialExamResultList;
  final List<TrialExamGraph> studentTrialExamGraphList;
  final TrialExamStudentResult trialExamStudentResult;
  final TrialExamGraph totalNetGraph;
  final TrialExamAverageHelper classAverages;
  final TrialExamAverageHelper schoolAverages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StudentExamInfoWidget(
            student: student,
            trialExamStudentResult: trialExamStudentResult,
            totalNetGraph: totalNetGraph,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          StudentExamAveragesWidget(
            trialExamStudentResult: trialExamStudentResult,
            schoolAverages: schoolAverages,
            classAverages: classAverages,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          StudentExamLineGraphisWidget(
            studentTrialExamGraphList: studentTrialExamGraphList,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          StudentExamResultListWidget(studentTrialExamResultList: studentTrialExamResultList),
        ],
      ),
    );
  }
}
