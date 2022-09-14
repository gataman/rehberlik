import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/helper/trial_exam_graph/trial_exam_graph.dart';

import '../../../common/constants.dart';

class TrialExamBarChart extends StatelessWidget {
  final TrialExamGraph trialExamGraph;

  const TrialExamBarChart({Key? key, required this.trialExamGraph}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: defaultBoxDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(trialExamGraph.graphLabelName),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(
                  horizontalInterval: trialExamGraph.lessonType == LessonType.twenty ? 2 : 1,
                  drawVerticalLine: false,
                ),
                groupsSpace: 10,
                barGroups: _getBarChartGroupData(trialExamGraph.itemList),
                borderData: FlBorderData(
                    border: Border.all(
                  color: Colors.white10,
                )),
                titlesData: _getTitlesSettings(),
                minY: 0,
                maxY: trialExamGraph.lessonType == LessonType.twenty ? 20 : 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final int index = value.toInt();
    final style = TextStyle(
      color: index < colorList.length ? colorList[index] : Colors.amber,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1,
      child: Text(trialExamGraph.itemList[index].itemName, style: style),
    );
  }

  List<BarChartGroupData> _getBarChartGroupData(List<TrialExamGraphItem> itemList) {
    List<BarChartGroupData> barChartGroupDataList = [];

    for (var i = 0; i < itemList.length; i++) {
      final groupData = BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: itemList[i].value,
            color: i < colorList.length ? colorList[i] : Colors.amber,
          )
        ],
      );

      barChartGroupDataList.add(groupData);
    }

    return barChartGroupDataList;
  }

  _getTitlesSettings() {
    return FlTitlesData(
      show: true,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
            showTitles: true,
            interval: trialExamGraph.lessonType == LessonType.twenty ? 2 : 1,
            reservedSize: 24,
            getTitlesWidget: (value, meta) {
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  value.toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              );
            }),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true, getTitlesWidget: getTitles),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  List<Color> get colorList =>
      <Color>[Colors.redAccent, Colors.amber, Colors.green, Colors.lightBlueAccent, Colors.purpleAccent, Colors.teal];
}
