import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/core/widgets/charts/bar_charts/trial_exam_bar_chart.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/cubit/trial_exam_result_cubit.dart';

import '../../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';

class TrialExamResultStaticsView extends StatefulWidget {
  const TrialExamResultStaticsView({Key? key}) : super(key: key);

  @override
  State<TrialExamResultStaticsView> createState() => _TrialExamResultStaticsViewState();
}

class _TrialExamResultStaticsViewState extends State<TrialExamResultStaticsView> {
  @override
  Widget build(BuildContext context) {
    final trialExamGraphList = context.read<TrialExamResultCubit>().trialExamGraphList;
    return _getGraphWidgetList(trialExamGraphList);
  }

  Widget _getGraphWidgetList(List<TrialExamGraph> graphList) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: graphList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
            childAspectRatio: Responsive.isMobile(context) ? 2 : 1.5,
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
