import 'package:flutter/material.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../common/constants.dart';
import '../../../../../models/trial_exam_result.dart';
import '../../../../../responsive.dart';

class StudentExamResultListWidget extends StatefulWidget {
  const StudentExamResultListWidget({Key? key, required this.studentTrialExamResultList}) : super(key: key);
  final List<TrialExamResult> studentTrialExamResultList;

  @override
  State<StudentExamResultListWidget> createState() => _StudentExamResultListWidgetState();
}

class _StudentExamResultListWidgetState extends State<StudentExamResultListWidget> {
  final String _dogruLabel = "Doğ";
  final String _netLabel = "Net";
  final String _yanlisLabel = "Yan";
  final String _puanLabel = "Puan";

  late List<TrialExamResult> _trialExamResultList;
  late _DataSource _dataSource;

  @override
  void initState() {
    _trialExamResultList = widget.studentTrialExamResultList;
    _dataSource = _DataSource(trialExamResultList: _trialExamResultList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Theme.of(context).dividerColor),
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: SfDataGrid(
        shrinkWrapRows: true,
        allowSorting: true,
        columnWidthMode: _getWidthMode(),
        frozenColumnsCount: 1,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        headerRowHeight: 30,
        defaultColumnWidth: Responsive.isMobile(context) ? 35 : double.nan,
        rowHeight: 40,
        stackedHeaderRows: _getStackedHeaderRows(),
        source: _dataSource,
        columns: _getColumns(),
      ),
    );
  }

  List<StackedHeaderRow> _getStackedHeaderRows() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(columnNames: <String>[
          'exam_name',
        ], child: _getWidgetForStackedHeaderCell('Sınav Adı')),
        StackedHeaderCell(columnNames: <String>[
          'turDog',
          'turYan',
          'turNet',
        ], child: _getWidgetForStackedHeaderCell('Türkçe')),
        StackedHeaderCell(columnNames: <String>[
          'matDog',
          'matYan',
          'matNet',
        ], child: _getWidgetForStackedHeaderCell('Matematik')),
        StackedHeaderCell(columnNames: <String>[
          'fenDog',
          'fenYan',
          'fenNet',
        ], child: _getWidgetForStackedHeaderCell('Fen')),
        StackedHeaderCell(columnNames: <String>[
          'sosDog',
          'sosYan',
          'sosNet',
        ], child: _getWidgetForStackedHeaderCell('Sosyal')),
        StackedHeaderCell(columnNames: <String>[
          'ingDog',
          'ingYan',
          'ingNet',
        ], child: _getWidgetForStackedHeaderCell('İngilizce')),
        StackedHeaderCell(columnNames: <String>[
          'dinDog',
          'dinYan',
          'dinNet',
        ], child: _getWidgetForStackedHeaderCell('Din')),
        StackedHeaderCell(columnNames: <String>[
          'topDog',
          'topYan',
          'topNet',
          'topPuan',
        ], child: _getWidgetForStackedHeaderCell('Toplam')),
      ])
    ];
    return stackedHeaderRows;
  }

  Widget _getWidgetForStackedHeaderCell(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.center,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  List<GridColumn> _getColumns() {
    return <GridColumn>[
      GridColumn(
        width: 100,
        columnName: 'exam_name',
        label: _getLabelTitleText("Sınav Adı"),
      ),
      GridColumn(columnName: 'turDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'turYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'turNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'matDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'matYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'matNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'fenDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'fenYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'fenNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'sosDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'sosYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'sosNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'ingDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'ingYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'ingNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'dinDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'dinYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'dinNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'topDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'topYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'topNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'topPuan', width: 40, label: _getLabelTitleText(_puanLabel)),
    ];
  }

  Widget _getLabelTitleText(String value) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        value,
        style: defaultDataTableTitleStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  ColumnWidthMode _getWidthMode() => Responsive.isMobile(context) ? ColumnWidthMode.none : ColumnWidthMode.fill;
}

class _DataSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = <DataGridRow>[];
  //List<TrialExamResult> _trialExamResultList = <TrialExamResult>[];

  _DataSource({required List<TrialExamResult> trialExamResultList}) {
    _dataGridRows = trialExamResultList.map<DataGridRow>((TrialExamResult e) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'exam_name', value: e.trialExam!.examName!),
        DataGridCell<int>(columnName: 'turDog', value: e.turDog),
        DataGridCell<int>(columnName: 'turYan', value: e.turYan),
        DataGridCell<double>(columnName: 'turNet', value: e.turNet!.decimalCount(2)),
        DataGridCell<int>(columnName: 'matDog', value: e.matDog),
        DataGridCell<int>(columnName: 'matYan', value: e.matYan),
        DataGridCell<double>(columnName: 'matNet', value: e.matNet!.decimalCount(2)),
        DataGridCell<int>(columnName: 'fenDog', value: e.fenDog),
        DataGridCell<int>(columnName: 'fenYan', value: e.fenYan),
        DataGridCell<double>(columnName: 'fenNet', value: e.fenNet!.decimalCount(2)),
        DataGridCell<int>(columnName: 'sosDog', value: e.sosDog),
        DataGridCell<int>(columnName: 'sosYan', value: e.sosYan),
        DataGridCell<double>(columnName: 'sosNet', value: e.sosNet!.decimalCount(2)),
        DataGridCell<int>(columnName: 'ingDog', value: e.ingDog),
        DataGridCell<int>(columnName: 'ingYan', value: e.ingYan),
        DataGridCell<double>(columnName: 'ingNet', value: e.ingNet!.decimalCount(2)),
        DataGridCell<int>(columnName: 'dinDog', value: e.dinDog),
        DataGridCell<int>(columnName: 'dinYan', value: e.dinYan),
        DataGridCell<double>(columnName: 'dinNet', value: e.dinNet!.decimalCount(2)),
        DataGridCell<int>(columnName: 'topDog', value: _getTopDog(e)),
        DataGridCell<int>(columnName: 'topYan', value: _getTopYan(e)),
        DataGridCell<double>(columnName: 'topNet', value: _getTopNet(e).decimalCount(2)),
        DataGridCell<double>(columnName: 'topPuan', value: e.totalPoint!.decimalCount(3)),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  int _getTopDog(TrialExamResult e) {
    return e.turDog! + e.matDog! + e.fenDog! + e.sosDog! + e.ingDog! + e.dinDog!;
  }

  int _getTopYan(TrialExamResult e) {
    return e.turYan! + e.matYan! + e.fenYan! + e.sosYan! + e.ingYan! + e.dinYan!;
  }

  double _getTopNet(TrialExamResult e) {
    return e.turNet! + e.matNet! + e.fenNet! + e.sosNet! + e.ingNet! + e.dinNet!;
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        padding: e.columnName == 'exam_name' ? const EdgeInsets.only(left: 3) : EdgeInsets.zero,
        alignment: e.columnName == 'exam_name' ? Alignment.centerLeft : Alignment.center,
        child: Text(
          e.value == null ? '  ' : e.value.toString(),
          style: _getNetTextStyle(e),
          textAlign: e.columnName == 'exam_name' ? TextAlign.start : TextAlign.center,
        ),
      );
    }).toList());
  }

  TextStyle _getNetTextStyle(DataGridCell e) {
    if (e.columnName == 'exam_name') {
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
          e.columnName == 'topNet') {
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
}
