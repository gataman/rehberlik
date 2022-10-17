import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/helper/trial_exam_graph/trial_exam_graph.dart';

class TrialExamStudentLineChart2 extends StatelessWidget {
  const TrialExamStudentLineChart2({Key? key, required this.examGraph, required this.lessonIndex}) : super(key: key);

  final TrialExamGraph examGraph;
  final int lessonIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            examGraph.graphLabelName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colorList[lessonIndex]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: examGraph.lessonType == LessonType.total
                    ? 100
                    : examGraph.lessonType == LessonType.twenty
                        ? 20
                        : 10,
                minX: 0,
                maxX: 10,
                gridData: _getGridData(context),
                borderData: FlBorderData(
                    border: Border.all(
                  color: Theme.of(context).dividerColor,
                )),
                lineBarsData: [
                  LineChartBarData(
                    color: colorList[lessonIndex],
                    show: true,
                    isCurved: true,
                    dotData: FlDotData(getDotPainter: ((spot, xPercentage, bar, index) {
                      return FlDotCirclePainter(
                        radius: 1.7,
                        strokeWidth: 1,
                        strokeColor: colorList[lessonIndex],
                        color: colorList[lessonIndex],
                        //strokeColor: _defaultGetDotStrokeColor(spot, xPercentage, bar),
                      );
                    })),
                    spots: _getFlSpotsData,
                  ),
                ],
                titlesData: _getTitlesData(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getTitles(double value, TitleMeta meta, BuildContext context) {
    final int index = value.toInt();
    final style = TextStyle(fontSize: 10, color: colorList[lessonIndex]);

    if (examGraph.itemList.isEmpty || index == 0 || index > examGraph.itemList.length) {
      return const Text('');
    } else {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        angle: -1.5707963268,
        space: 1,
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            examGraph.itemList[index - 1].itemName,
            style: style,
            //textScaleFactor: .7,
          ),
        ),
      );
    }
  }

  FlGridData _getGridData(BuildContext context) {
    return FlGridData(
      getDrawingHorizontalLine: ((value) {
        return _getDrawingLine(context);
      }),
      getDrawingVerticalLine: ((value) {
        return _getDrawingLine(context);
      }),
      verticalInterval: 1,
      horizontalInterval: examGraph.lessonType == LessonType.total
          ? 10
          : examGraph.lessonType == LessonType.twenty
              ? 2
              : 1,
    );
  }

  List<FlSpot>? get _getFlSpotsData {
    final list = examGraph.itemList;
    if (list.isNotEmpty) {
      List<FlSpot> flSpotList = [];

      for (var i = 0; i < list.length; i++) {
        flSpotList.add(FlSpot((i + 1).toDouble(), list[i].value));
      }

      return flSpotList;
    } else {
      return null;
    }
  }

  FlLine _getDrawingLine(BuildContext context) =>
      FlLine(color: Theme.of(context).dividerColor, strokeWidth: .7, dashArray: [1, 3]);

  FlTitlesData _getTitlesData(BuildContext context) {
    return FlTitlesData(
      show: true,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
            showTitles: true,
            interval: examGraph.lessonType == LessonType.total
                ? 10
                : examGraph.lessonType == LessonType.twenty
                    ? 2
                    : 1,
            reservedSize: 24,
            getTitlesWidget: (value, meta) {
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  value.toString(),
                  style: TextStyle(fontSize: 8, color: colorList[lessonIndex]),
                ),
              );
            }),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => _getTitles(value, meta, context),
          interval: 1,
        ),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  List<Color> get colorList => <Color>[
        Colors.redAccent,
        Colors.amber,
        Colors.green,
        Colors.lightBlueAccent,
        Colors.purpleAccent,
        Colors.teal,
        Colors.deepOrange
      ];
}
