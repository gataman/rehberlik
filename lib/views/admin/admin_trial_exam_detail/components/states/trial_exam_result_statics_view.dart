import 'package:flutter/material.dart';
import '../../../../../common/constants.dart';
import '../../../../../core/widgets/charts/bar_charts/trial_exam_bar_chart.dart';
import '../../../../../responsive.dart';

import '../../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';

class TrialExamResultStaticsView extends StatelessWidget {
  const TrialExamResultStaticsView({Key? key, required this.trialExamGraphList}) : super(key: key);
  final List<TrialExamGraph> trialExamGraphList;

  @override
  Widget build(BuildContext context) {
    return _getGraphWidgetList(trialExamGraphList, context);
  }

  Widget _getGraphWidgetList(List<TrialExamGraph> graphList, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: graphList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
            childAspectRatio: Responsive.isMobile(context) ? 1.2 : 1.5,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding + 8,
          ),
          itemBuilder: (context, index) {
            return TrialExamBarChart(
              trialExamGraph: graphList[index],
            );
          }),
    );
  }
}
