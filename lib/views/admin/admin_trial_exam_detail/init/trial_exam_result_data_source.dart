import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../models/helpers/trial_exam_average.dart';
import '../../../../models/trial_exam_result.dart';

class TrialExamResultDataSource extends DataGridSource {
  TrialExamResultDataSource({required List<TrialExamResult> trialExamResultList}) {
    _trialExamResultList = trialExamResultList;
    // _tiralExamResultDataGridRowList.clear();
    // _tiralExamResultDataGridRowList.add(_getFooter());
    _tiralExamResultDataGridRowList = trialExamResultList
        .map((e) => DataGridRow(
              cells: [
                DataGridCell<String>(columnName: 'student_no', value: e.studentNumber),
                DataGridCell<String>(columnName: 'student_name', value: e.studentName),
                DataGridCell<String>(columnName: 'student_class', value: e.className),
                DataGridCell<int>(columnName: 'turDog', value: e.turDog),
                DataGridCell<int>(columnName: 'turYan', value: e.turYan),
                DataGridCell<double>(columnName: 'turNet', value: _getNumberFormat(e.turNet)),
                DataGridCell<int>(columnName: 'matDog', value: e.matDog),
                DataGridCell<int>(columnName: 'matYan', value: e.matYan),
                DataGridCell<double>(columnName: 'matNet', value: _getNumberFormat(e.matNet)),
                DataGridCell<int>(columnName: 'fenDog', value: e.fenDog),
                DataGridCell<int>(columnName: 'fenYan', value: e.fenYan),
                DataGridCell<double>(columnName: 'fenNet', value: _getNumberFormat(e.fenNet)),
                DataGridCell<int>(columnName: 'sosDog', value: e.sosDog),
                DataGridCell<int>(columnName: 'sosYan', value: e.sosYan),
                DataGridCell<double>(columnName: 'sosNet', value: _getNumberFormat(e.sosNet)),
                DataGridCell<int>(columnName: 'ingDog', value: e.ingDog),
                DataGridCell<int>(columnName: 'ingYan', value: e.ingYan),
                DataGridCell<double>(columnName: 'ingNet', value: _getNumberFormat(e.ingNet)),
                DataGridCell<int>(columnName: 'dinDog', value: e.dinDog),
                DataGridCell<int>(columnName: 'dinYan', value: e.dinYan),
                DataGridCell<double>(columnName: 'dinNet', value: _getNumberFormat(e.dinNet)),
                DataGridCell<int>(columnName: 'topDog', value: _getTopDog(e)),
                DataGridCell<int>(columnName: 'topYan', value: _getTopYan(e)),
                DataGridCell<double>(columnName: 'topNet', value: _getNumberFormat(_getTopNet(e))),
                DataGridCell<int>(columnName: 'classRank', value: e.classRank),
                DataGridCell<int>(columnName: 'schoolRank', value: e.schoolRank),
                DataGridCell<double>(columnName: 'totalPoint', value: _getNumberFormatForPoint(e.totalPoint)),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _tiralExamResultDataGridRowList = [];
  List<TrialExamResult> _trialExamResultList = [];

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        padding: e.columnName == 'totalPoint' || e.columnName == 'student_name'
            ? const EdgeInsets.only(left: 3)
            : EdgeInsets.zero,
        alignment:
            e.columnName == 'totalPoint' || e.columnName == 'student_name' ? Alignment.centerLeft : Alignment.center,
        child: AutoSizeText(
          e.value == null ? '  ' : e.value.toString(),
          style: _getNetTextStyle(e),
          textAlign:
              e.columnName == 'totalPoint' || e.columnName == 'student_name' ? TextAlign.start : TextAlign.center,
        ),
      );
    }).toList());
  }

  @override
  List<DataGridRow> get rows => _tiralExamResultDataGridRowList;

  double _getNumberFormat(double? net) {
    if (net != null) {
      final format = NumberFormat('#.00', 'en_US').format(net);
      return double.parse(format);
    } else {
      return 0;
    }
  }

  double _getNumberFormatForPoint(double? net) {
    if (net != null) {
      final format = NumberFormat('#.000', 'en_US').format(net);
      return double.parse(format);
    } else {
      return 0;
    }
  }

  TextStyle _getNetTextStyle(DataGridCell e) {
    if (e.columnName == 'student_name' || e.columnName == 'student_no' || e.columnName == 'student_class') {
      return const TextStyle(
        fontSize: 12,
        color: Colors.amber,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      if (e.columnName == 'turNet' ||
          e.columnName == 'matNet' ||
          e.columnName == 'fenNet' ||
          e.columnName == 'ingNet' ||
          e.columnName == 'sosNet' ||
          e.columnName == 'dinNet' ||
          e.columnName == 'totalPoint') {
        return const TextStyle(
          fontSize: 12,
          color: Colors.amber,
          overflow: TextOverflow.ellipsis,
        );
      } else {
        return const TextStyle(
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
        );
      }
    }
  }

  int _getTopDog(TrialExamResult e) {
    return e.turDog! + e.matDog! + e.fenDog! + e.sosDog! + e.ingDog! + e.dinDog!;
  }

  int _getTopYan(TrialExamResult e) {
    return e.turYan! + e.matYan! + e.fenYan! + e.sosYan! + e.ingYan! + e.dinYan!;
  }

  double _getTopNet(TrialExamResult e) {
    return e.turNet! + e.matNet! + e.fenNet! + e.sosNet! + e.ingNet! + e.dinNet!;
  }
}