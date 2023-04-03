import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../models/trial_exam_result.dart';

class TrialExamResultDataSource extends DataGridSource {
  TrialExamResultDataSource({required List<TrialExamResult> trialExamResultList}) {
    // _tiralExamResultDataGridRowList.clear();
    // _tiralExamResultDataGridRowList.add(_getFooter());
    _tiralExamResultDataGridRowList = trialExamResultList
        .map((e) => DataGridRow(
              cells: [
                DataGridCell<int>(columnName: 'okulS', value: e.schoolRank),
                DataGridCell<String>(columnName: 'Adı Soyadı', value: e.studentName),
                DataGridCell<int>(columnName: 'No', value: int.parse(e.studentNumber)),
                DataGridCell<String>(columnName: 'Sınıfı', value: e.className),
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
                DataGridCell<int>(columnName: 'sınıfS', value: e.classRank),
                DataGridCell<double>(columnName: 'puan', value: _getNumberFormatForPoint(e.totalPoint)),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _tiralExamResultDataGridRowList = [];

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        padding:
            e.columnName == 'puan' || e.columnName == 'Adı Soyadı' ? const EdgeInsets.only(left: 3) : EdgeInsets.zero,
        alignment: e.columnName == 'puan' || e.columnName == 'Adı Soyadı' ? Alignment.centerLeft : Alignment.center,
        child: Text(
          e.value == null ? '  ' : e.value.toString(),
          maxLines: 1,
          style: _getNetTextStyle(e),
          textAlign: e.columnName == 'puan' || e.columnName == 'Adı Soyadı' ? TextAlign.start : TextAlign.center,
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
    if (e.columnName == 'Adı Soyadı' || e.columnName == 'No' || e.columnName == 'Sınıfı') {
      return const TextStyle(
        fontSize: 10,
        color: Colors.amber,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.visible,
      );
    } else {
      if (e.columnName == 'turNet' ||
          e.columnName == 'matNet' ||
          e.columnName == 'fenNet' ||
          e.columnName == 'ingNet' ||
          e.columnName == 'sosNet' ||
          e.columnName == 'dinNet' ||
          e.columnName == 'puan') {
        return const TextStyle(
          fontSize: 10,
          color: Colors.amber,
          overflow: TextOverflow.ellipsis,
        );
      } else {
        return const TextStyle(
          fontSize: 10,
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
