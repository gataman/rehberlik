import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;
import '../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';

class TrialExamStudentLineChart extends StatefulWidget {
  const TrialExamStudentLineChart({Key? key, required this.examGraph, required this.lessonIndex}) : super(key: key);
  final TrialExamGraph examGraph;
  final int lessonIndex;

  @override
  State<TrialExamStudentLineChart> createState() => _TrialExamStudentLineChartState();
}

class _TrialExamStudentLineChartState extends State<TrialExamStudentLineChart> {
  late GlobalKey<SfCartesianChartState> _cartesianChartKey;

  late TrialExamGraph examGraph;
  late int lessonIndex;
  @override
  void initState() {
    _cartesianChartKey = GlobalKey();
    examGraph = widget.examGraph;
    lessonIndex = widget.lessonIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      key: _cartesianChartKey,
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: examGraph.graphLabelName,
          textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: colorList[lessonIndex])),
      //legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: CategoryAxis(
          labelRotation: -90,
          interval: 1,
          majorTickLines: const MajorTickLines(size: 0),
          majorGridLines: const MajorGridLines(width: 0),
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            return ChartAxisLabel(
                details.axis.name == 'primaryXAxis' && details.text.contains(RegExp(r'[0-9]')) ? '' : details.text,
                TextStyle(fontSize: 10, color: colorList[lessonIndex]));
          }),
      /*
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          majorGridLines: const MajorGridLines(width: 0)),
          */
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: examGraph.lessonType == LessonType.total
              ? 100
              : examGraph.lessonType == LessonType.twenty
                  ? 20
                  : 10,
          interval: examGraph.lessonType == LessonType.total
              ? 10
              : examGraph.lessonType == LessonType.twenty
                  ? 2
                  : 1,
          labelFormat: '{value}',
          labelStyle: TextStyle(fontSize: 10, color: colorList[lessonIndex]),
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  Future<Uint8List> _renderChartAsImage() async {
    final ui.Image data = await _cartesianChartKey.currentState!.toImage();
    final ByteData? bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes = bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    return imageBytes;
    /*
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return Scaffold(body: Image.memory(imageBytes));
        },
      ),
    );
    */
  }

  List<LineSeries<TrialExamGraphItem, dynamic>> _getDefaultLineSeries() {
    return <LineSeries<TrialExamGraphItem, dynamic>>[
      LineSeries<TrialExamGraphItem, dynamic>(
          animationDuration: 2500,
          dataSource: widget.examGraph.itemList,
          xValueMapper: (TrialExamGraphItem item, _) => item.itemName,
          yValueMapper: (TrialExamGraphItem item, _) => item.value,
          width: 2,
          color: colorList[lessonIndex],
          name: examGraph.graphLabelName,
          pointColorMapper: (TrialExamGraphItem item, _) => colorList[lessonIndex],
          markerSettings: const MarkerSettings(isVisible: true)),
    ];
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


/*

    //Dikey çizgi çizer


      trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings: const InteractiveTooltip(format: 'point.x : point.y'))
*/