import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/core/widgets/bar_charts/trial_exam_bar_chart.dart';
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

  List<TrialExamGraph> _getList() {
    final List<TrialExamGraph> graphList = [];
    var turkceGraph = TrialExamGraph(graphLabelName: 'Türkçe', lessonType: LessonType.twenty);
    turkceGraph.itemList.add(TrialExamGraphItem(itemName: '5-A', value: 10.2));
    turkceGraph.itemList.add(TrialExamGraphItem(itemName: '5-B', value: 11.1));
    turkceGraph.itemList.add(TrialExamGraphItem(itemName: '5-C', value: 9.2));
    turkceGraph.itemList.add(TrialExamGraphItem(itemName: '5-D', value: 8.5));
    turkceGraph.itemList.add(TrialExamGraphItem(itemName: '5-E', value: 7.2));
    turkceGraph.itemList.add(TrialExamGraphItem(itemName: 'Toplam', value: 10.3));

    var mathGraph = TrialExamGraph(graphLabelName: 'Matematik', lessonType: LessonType.twenty);
    mathGraph.itemList.add(TrialExamGraphItem(itemName: '5-A', value: 5.2));
    mathGraph.itemList.add(TrialExamGraphItem(itemName: '5-B', value: 4.2));
    mathGraph.itemList.add(TrialExamGraphItem(itemName: '5-C', value: 6.1));
    mathGraph.itemList.add(TrialExamGraphItem(itemName: '5-D', value: 4.5));
    mathGraph.itemList.add(TrialExamGraphItem(itemName: '5-E', value: 3.2));
    mathGraph.itemList.add(TrialExamGraphItem(itemName: 'Toplam', value: 4.7));

    var fenGraph = TrialExamGraph(graphLabelName: 'Fen Bilgisi', lessonType: LessonType.twenty);
    fenGraph.itemList.add(TrialExamGraphItem(itemName: '5-A', value: 9.2));
    fenGraph.itemList.add(TrialExamGraphItem(itemName: '5-B', value: 8.5));
    fenGraph.itemList.add(TrialExamGraphItem(itemName: '5-C', value: 8.2));
    fenGraph.itemList.add(TrialExamGraphItem(itemName: '5-D', value: 7.9));
    fenGraph.itemList.add(TrialExamGraphItem(itemName: '5-E', value: 10.2));
    fenGraph.itemList.add(TrialExamGraphItem(itemName: 'Toplam', value: 8.4));

    var sosGraph = TrialExamGraph(graphLabelName: 'Sosyal B.', lessonType: LessonType.ten);
    sosGraph.itemList.add(TrialExamGraphItem(itemName: '5-A', value: 7.2));
    sosGraph.itemList.add(TrialExamGraphItem(itemName: '5-B', value: 6.5));
    sosGraph.itemList.add(TrialExamGraphItem(itemName: '5-C', value: 5.2));
    sosGraph.itemList.add(TrialExamGraphItem(itemName: '5-D', value: 7.9));
    sosGraph.itemList.add(TrialExamGraphItem(itemName: '5-E', value: 8.2));
    sosGraph.itemList.add(TrialExamGraphItem(itemName: 'Toplam', value: 7.4));

    graphList.add(turkceGraph);
    graphList.add(mathGraph);
    graphList.add(fenGraph);
    graphList.add(sosGraph);

    return graphList;
  }

  Widget _getGraphWidgetList(List<TrialExamGraph> graphList) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: graphList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.5,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
          ),
          itemBuilder: (context, index) {
            return TrialExamBarChart(
              trialExamGraph: graphList[index],
            );
          }),
    );
  }
}
