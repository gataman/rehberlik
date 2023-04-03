import 'package:flutter/material.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';
import '../../../../../core/widgets/charts/line_charts/trial_exam_student_line_chart.dart';
import '../../../../../responsive.dart';

class StudentExamLineGraphisWidget extends StatelessWidget {
  const StudentExamLineGraphisWidget({Key? key, required this.studentTrialExamGraphList}) : super(key: key);
  final List<TrialExamGraph> studentTrialExamGraphList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: studentTrialExamGraphList.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
          maxCrossAxisExtent: 375,
          childAspectRatio: Responsive.isMobile(context) ? 1.5 : 1.1,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding + 8,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: TrialExamStudentLineChart(
              examGraph: studentTrialExamGraphList[index],
              lessonIndex: index,
            ),
          );
        });
  }
}

/*
 TrialExamStudentLineChart(
              examGraph: studentTrialExamGraphList[index],
              lessonIndex: index,
            )
*/
