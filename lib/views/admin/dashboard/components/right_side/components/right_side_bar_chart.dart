import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RightSideBarChart extends StatelessWidget {
  const RightSideBarChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: BarChart(
        BarChartData(
            gridData: FlGridData(
              horizontalInterval: 25,
              drawVerticalLine: false,
            ),
            groupsSpace: 10,
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: 65,
                    color: Colors.redAccent,
                  )
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: 75,
                    color: Colors.amber,
                  )
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: 45,
                    color: Colors.green,
                  )
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(toY: 55, color: Colors.lightBlueAccent)
                ],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [BarChartRodData(toY: 25, color: Colors.purpleAccent)],
              ),
              BarChartGroupData(
                x: 5,
                barRods: [BarChartRodData(toY: 45, color: Colors.teal)],
              ),
            ],
            borderData: FlBorderData(
                border: Border.all(
              color: Colors.white10,
            )),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, interval: 25, reservedSize: 32),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles:
                    SideTitles(showTitles: true, getTitlesWidget: getTitles),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            minY: 0,
            maxY: 100),
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Tür', style: style);
        break;
      case 1:
        text = const Text('Sos', style: style);
        break;
      case 2:
        text = const Text('Din', style: style);
        break;
      case 3:
        text = const Text('İng', style: style);
        break;
      case 4:
        text = const Text('Mat', style: style);
        break;
      case 5:
        text = const Text('Fen', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: text,
    );
  }
}
