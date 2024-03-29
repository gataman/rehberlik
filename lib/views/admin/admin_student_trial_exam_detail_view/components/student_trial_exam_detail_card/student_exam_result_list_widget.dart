import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/extensions.dart';
import '../../../../../core/widgets/data_table/sf_data_grid_icon.dart';
import '../../../../../models/trial_exam_result.dart';
import '../../../../../responsive.dart';

class StudentExamResultListWidget extends StatefulWidget {
  const StudentExamResultListWidget({Key? key, required this.studentTrialExamResultList}) : super(key: key);
  final List<TrialExamResult> studentTrialExamResultList;

  @override
  State<StudentExamResultListWidget> createState() => _StudentExamResultListWidgetState();
}

class _StudentExamResultListWidgetState extends State<StudentExamResultListWidget> {
//SECTION - init
  //SECTION - labels
  final String _dogruLabel = "Doğ";
  final String _netLabel = "Net";
  final String _yanlisLabel = "Yan";
  final String _puanLabel = "Puan";
  final String _classRankLabel = "Sınıf";
  final String _schoolRankLabel = "Okul";
  //!SECTION

  late List<TrialExamResult> _trialExamResultList;
  late _DataSource _dataSource;

  @override
  void initState() {
    _trialExamResultList = widget.studentTrialExamResultList;
    super.initState();
  }

//!SECTION

//SECTION - State Build
  //ANCHOR - build
  @override
  Widget build(BuildContext context) {
    _dataSource = _DataSource(trialExamResultList: _trialExamResultList);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Theme.of(context).dividerColor),
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: SfDataGridIcon(
        dataGridSource: _dataSource,
        child: SfDataGrid(
          verticalScrollPhysics: const NeverScrollableScrollPhysics(),
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
      ),
    );
  }

  //ANCHOR - _getStackedHeaderRows
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
          'classRank',
          'schoolRank',
          'topPuan',
        ], child: _getWidgetForStackedHeaderCell('Toplam')),
      ])
    ];
    return stackedHeaderRows;
  }

  //ANCHOR - _getWidgetForStackedHeaderCell
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

  //ANCHOR - _getColumns
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
      GridColumn(columnName: 'classRank', label: _getLabelTitleText(_classRankLabel)),
      GridColumn(columnName: 'schoolRank', label: _getLabelTitleText(_schoolRankLabel)),
      GridColumn(columnName: 'topPuan', width: 40, label: _getLabelTitleText(_puanLabel)),
    ];
  }

  //ANCHOR - _getLabelTitleText
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

  //ANCHOR - _getWidthMode
  ColumnWidthMode _getWidthMode() => Responsive.isMobile(context) ? ColumnWidthMode.none : ColumnWidthMode.fill;

  //ANCHOR - _showDialog
  //void _showDialog(TrialExamResult result) {}
}
//!SECTION

//SECTION - _DataSource
class _DataSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = <DataGridRow>[];
  //ANCHOR - constructor
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
        DataGridCell<int>(columnName: 'classRank', value: e.classRank),
        DataGridCell<int>(columnName: 'schoolRank', value: e.schoolRank),
        DataGridCell<double>(columnName: 'topPuan', value: e.totalPoint!.decimalCount(3)),
      ]);
    }).toList();
  }

  //ANCHOR - buildRow
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

  //ANCHOR - _getClickableData
  // Widget _getClickableData(TrialExamResult result) {
  //   return InkWell(
  //     onTap: () {},
  //     child: CustomFormExamDialogWidget(
  //       examResult: result,
  //       child: _examNameWidget(result),
  //     ),
  //   );
  // }

  //ANCHOR - _examNameWidget
  // Widget _examNameWidget(TrialExamResult result) {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 3),
  //     alignment: Alignment.centerLeft,
  //     child: AutoSizeText(
  //       result.trialExam!.examName!,
  //       style: const TextStyle(
  //         fontSize: 12,
  //         color: Colors.amber,
  //         fontWeight: FontWeight.normal,
  //         overflow: TextOverflow.ellipsis,
  //       ),
  //       textAlign: TextAlign.start,
  //     ),
  //   );
  // }

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

  // @override
  // DataGridRowAdapter? buildRow(DataGridRow row) {
  //   return DataGridRowAdapter(
  //       cells: row.getCells().map<Widget>((e) {
  //     if (e.columnName == 'exam_name') {
  //       return e.value;
  //     } else {
  //       return Container(
  //         padding: EdgeInsets.zero,
  //         alignment: Alignment.center,
  //         child: Text(
  //           e.value == null ? '  ' : e.value.toString(),
  //           style: _getNetTextStyle(e),
  //           textAlign: TextAlign.center,
  //         ),
  //       );
  //     }
  //   }).toList());
  // }

  //ANCHOR - _getNetTextStyle
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

  //ANCHOR - _getFormElementList
  // List<FormElement> _getFormElementList(TrialExamResult result) => <FormElement>[
  //       FormElement(label: 'Türkçe Doğru', value: result.turDog.toString()),
  //       FormElement(label: 'Türkçe Yanlış', value: result.turYan.toString()),
  //       FormElement(label: 'Sosyal Doğru', value: result.sosDog.toString()),
  //       FormElement(label: 'Sosyal Yanlış', value: result.sosYan.toString()),
  //       FormElement(label: 'Din Doğru', value: result.dinDog.toString()),
  //       FormElement(label: 'Din Yanlış', value: result.dinYan.toString()),
  //       FormElement(label: 'İngilizce Doğru', value: result.ingDog.toString()),
  //       FormElement(label: 'İngilizce Yanlış', value: result.ingYan.toString()),
  //       FormElement(label: 'Matematik Doğru', value: result.matDog.toString()),
  //       FormElement(label: 'Matematik Yanlış', value: result.matYan.toString()),
  //       FormElement(label: 'Fen Doğru', value: result.fenDog.toString()),
  //       FormElement(label: 'Fen Yanlış', value: result.fenYan.toString()),
  //     ];
}

//!SECTION - _DataSource
