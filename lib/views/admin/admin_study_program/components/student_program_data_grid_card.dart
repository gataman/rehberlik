import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/models/study_program.dart';
import 'package:rehberlik/views/admin/admin_study_program/admin_study_program_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StudentProgramDataGridCard extends StatefulWidget {
  final String studentID;
  final DateTime startTime;

  const StudentProgramDataGridCard(
      {Key? key, required this.studentID, required this.startTime})
      : super(key: key);

  @override
  State<StudentProgramDataGridCard> createState() =>
      _StudentProgramDataGridCardState();
}

class _StudentProgramDataGridCardState
    extends State<StudentProgramDataGridCard> {
  //region Properties
  late AdminStudyProgramController _controller;
  late StudyProgramDataSource _programDataSource;

  final DataGridController _dataGridController = DataGridController();

  final String _targetLabel = "Hed";
  final String _solvedLabel = "Çöz";
  final String _correctLabel = "Doğ";
  final String _incorrectLabel = "Yan";

  //endregion

  //region Overrides
  @override
  void initState() {
    debugPrint("İnitState Çalıştı");
    _controller = Get.put(AdminStudyProgramController());
    _controller.localProgramList = null;
    _programDataSource = StudyProgramDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 360,
          child: FutureBuilder<List<StudyProgram>?>(
              future:
                  _getStudentAllPrograms(widget.studentID, widget.startTime),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    _programDataSource.updateList(programList: snapshot.data!);
                  }
                  return _programDataGridCard();
                } else {
                  return Container(
                      decoration: defaultBoxDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Center(
                              child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: DefaultCircularProgress())),
                        ],
                      ));
                }
              }),
        ),
      ],
    );
  }

  //endregion

  //region Methods
  Future<List<StudyProgram>?> _getStudentAllPrograms(
      String _studentID, DateTime _startTime) {
    return _controller.getAllPrograms(
        studentID: _studentID, startTime: _startTime);
  }

  SfDataGrid _programDataGridCard() {
    return SfDataGrid(
        allowEditing: true,
        frozenColumnsCount: 2,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        headerRowHeight: 30,
        defaultColumnWidth: 35,
        rowHeight: 40,
        allowColumnsResizing: true,
        editingGestureType: EditingGestureType.tap,
        navigationMode: GridNavigationMode.cell,
        selectionMode: SelectionMode.single,
        stackedHeaderRows: _getStackedHeaderRows(),
        controller: _dataGridController,
        selectionManager: SelectionController(onChanged: (_rowIndex) {
          _dataGridController.beginEdit(_rowIndex);
        }),
        source: _programDataSource,
        columns: _getColumns());
  }

  List<StackedHeaderRow> _getStackedHeaderRows() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(columnNames: <String>[
          'tarih',
          'gun',
        ], child: _getWidgetForStackedHeaderCell('')),
        StackedHeaderCell(columnNames: <String>[
          'turTarget',
          'turSolved',
          'turCorrect',
          'turIncorrect',
        ], child: _getWidgetForStackedHeaderCell('Türkçe')),
        StackedHeaderCell(columnNames: <String>[
          'matTarget',
          'matSolved',
          'matCorrect',
          'matIncorrect',
        ], child: _getWidgetForStackedHeaderCell('Matematik')),
        StackedHeaderCell(columnNames: <String>[
          'fenTarget',
          'fenSolved',
          'fenCorrect',
          'fenIncorrect',
        ], child: _getWidgetForStackedHeaderCell('Fen')),
        StackedHeaderCell(columnNames: <String>[
          'inkTarget',
          'inkSolved',
          'inkCorrect',
          'inkIncorrect',
        ], child: _getWidgetForStackedHeaderCell('İnkılap')),
        StackedHeaderCell(columnNames: <String>[
          'ingTarget',
          'ingSolved',
          'ingCorrect',
          'ingIncorrect',
        ], child: _getWidgetForStackedHeaderCell('İngilizce')),
        StackedHeaderCell(columnNames: <String>[
          'dinTarget',
          'dinSolved',
          'dinCorrect',
          'dinIncorrect',
        ], child: _getWidgetForStackedHeaderCell('Din')),
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
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.amber),
        ));
  }

  List<GridColumn> _getColumns() {
    return <GridColumn>[
      GridColumn(
          width: 100,
          columnName: 'tarih',
          label: _getLabelTitleText("Tarih"),
          allowEditing: false),
      GridColumn(
          width: 100,
          columnName: 'gun',
          label: _getLabelTitleText("Gün"),
          allowEditing: false),
      GridColumn(
          columnName: 'turTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(
          columnName: 'turSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(
          columnName: 'turCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(
          columnName: 'turIncorrect',
          label: _getLabelTitleText(_incorrectLabel)),
      GridColumn(
          columnName: 'matTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(
          columnName: 'matSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(
          columnName: 'matCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(
          columnName: 'matIncorrect',
          label: _getLabelTitleText(_incorrectLabel)),
      GridColumn(
          columnName: 'fenTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(
          columnName: 'fenSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(
          columnName: 'fenCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(
          columnName: 'fenIncorrect',
          label: _getLabelTitleText(_incorrectLabel)),
      GridColumn(
          columnName: 'inkTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(
          columnName: 'inkSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(
          columnName: 'inkCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(
          columnName: 'inkIncorrect',
          label: _getLabelTitleText(_incorrectLabel)),
      GridColumn(
          columnName: 'ingTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(
          columnName: 'ingSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(
          columnName: 'ingCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(
          columnName: 'ingIncorrect',
          label: _getLabelTitleText(_incorrectLabel)),
      GridColumn(
          columnName: 'dinTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(
          columnName: 'dinSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(
          columnName: 'dinCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(
          columnName: 'dinIncorrect',
          label: _getLabelTitleText(_incorrectLabel)),
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
}

class StudyProgramDataSource extends DataGridSource {
  //region Properties
  final _controller = Get.put(AdminStudyProgramController());

  List<DataGridRow> _programsDataGridRows = [];

  List<StudyProgram> _programList = [];

  TextEditingController editingController = TextEditingController();

  dynamic _newCellValue;

  //endregion

  //region Overrides
  @override
  List<DataGridRow> get rows => _programsDataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value == null ? '  ' : e.value.toString(),
          style: TextStyle(
              fontSize: 14,
              color: (e.columnName == 'tarih' || e.columnName == 'gun')
                  ? Colors.amber
                  : Colors.white54),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }

  @override
  bool onCellBeginEdit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
        .getCells()
        .firstWhereOrNull((DataGridCell dataGridCell) =>
            dataGridCell.columnName == column.columnName)
        ?.value;

    _newCellValue = oldValue;
    return super.onCellBeginEdit(dataGridRow, rowColumnIndex, column);
  }

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
        .getCells()
        .firstWhereOrNull((DataGridCell dataGridCell) =>
            dataGridCell.columnName == column.columnName)
        ?.value;

    final int dataRowIndex = _programsDataGridRows.indexOf(dataGridRow);

    if (oldValue == _newCellValue) {
      return;
    }

    _programsDataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
        DataGridCell<double>(
            columnName: column.columnName, value: _newCellValue);

    _chageProgramValue(
        program: _programList[rowColumnIndex.rowIndex],
        columnName: column.columnName);
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    return _buildTextFieldWidget(displayText, column, submitCell);
  }

  //endregion

  //region Methods
  void updateList({required List<StudyProgram> programList}) async {
    if (programList.isNotEmpty) {
      _programList = programList;
      _programsDataGridRows = programList
          .map(
            (e) => DataGridRow(
              cells: [
                DataGridCell<String>(
                    columnName: 'tarih',
                    value: DateFormat("dd.MM.yyyy").format(e.date!)),
                DataGridCell<String>(
                    columnName: 'gun',
                    value: DateFormat("EEEE", 'tr').format(e.date!)),
                DataGridCell<int>(columnName: 'turTarget', value: e.turTarget),
                DataGridCell<int>(columnName: 'turSolved', value: e.turSolved),
                DataGridCell<int>(
                    columnName: 'turCorrect', value: e.turCorrect),
                DataGridCell<int>(
                    columnName: 'turIncorrect', value: e.turIncorrect),
                DataGridCell<int>(columnName: 'matTarget', value: e.matTarget),
                DataGridCell<int>(columnName: 'matSolved', value: e.matSolved),
                DataGridCell<int>(
                    columnName: 'matCorrect', value: e.matCorrect),
                DataGridCell<int>(
                    columnName: 'matIncorrect', value: e.matIncorrect),
                DataGridCell<int>(columnName: 'fenTarget', value: e.fenTarget),
                DataGridCell<int>(columnName: 'fenSolved', value: e.fenSolved),
                DataGridCell<int>(
                    columnName: 'fenCorrect', value: e.fenCorrect),
                DataGridCell<int>(
                    columnName: 'fenIncorrect', value: e.fenIncorrect),
                DataGridCell<int>(columnName: 'inkTarget', value: e.inkTarget),
                DataGridCell<int>(columnName: 'inkSolved', value: e.inkSolved),
                DataGridCell<int>(
                    columnName: 'inkCorrect', value: e.inkCorrect),
                DataGridCell<int>(
                    columnName: 'inkIncorrect', value: e.inkIncorrect),
                DataGridCell<int>(columnName: 'ingTarget', value: e.ingTarget),
                DataGridCell<int>(columnName: 'ingSolved', value: e.ingSolved),
                DataGridCell<int>(
                    columnName: 'ingCorrect', value: e.ingCorrect),
                DataGridCell<int>(
                    columnName: 'ingIncorrect', value: e.ingIncorrect),
                DataGridCell<int>(columnName: 'dinTarget', value: e.dinTarget),
                DataGridCell<int>(columnName: 'dinSolved', value: e.dinSolved),
                DataGridCell<int>(
                    columnName: 'dinCorrect', value: e.dinCorrect),
                DataGridCell<int>(
                    columnName: 'dinIncorrect', value: e.dinIncorrect),
              ],
            ),
          )
          .toList();
      notifyListeners();
    }
  }

  void _chageProgramValue(
      {required StudyProgram program, required String columnName}) {
    debugPrint("Değişecek Program ${program.toString()}");
    debugPrint("Değişecek Column Adı $columnName");
    debugPrint("NewValue $_newCellValue");
    switch (columnName) {
      case 'turTarget':
        program.turTarget = _newCellValue;
        break;
      case 'turSolved':
        program.turSolved = _newCellValue;
        break;
      case 'turCorrect':
        program.turCorrect = _newCellValue;
        break;
      case 'turIncorrect':
        program.turIncorrect = _newCellValue;
        break;

      case 'matTarget':
        program.matTarget = _newCellValue;
        break;
      case 'matSolved':
        program.matSolved = _newCellValue;
        break;
      case 'matCorrect':
        program.matCorrect = _newCellValue;
        break;
      case 'matIncorrect':
        program.matIncorrect = _newCellValue;
        break;

      case 'fenTarget':
        program.fenTarget = _newCellValue;
        break;
      case 'fenSolved':
        program.fenSolved = _newCellValue;
        break;
      case 'fenCorrect':
        program.fenCorrect = _newCellValue;
        break;
      case 'fenIncorrect':
        program.fenIncorrect = _newCellValue;
        break;

      case 'inkTarget':
        program.inkTarget = _newCellValue;
        break;
      case 'inkSolved':
        program.inkSolved = _newCellValue;
        break;
      case 'inkCorrect':
        program.inkCorrect = _newCellValue;
        break;
      case 'inkIncorrect':
        program.inkIncorrect = _newCellValue;
        break;

      case 'ingTarget':
        program.ingTarget = _newCellValue;
        break;
      case 'ingSolved':
        program.ingSolved = _newCellValue;
        break;
      case 'ingCorrect':
        program.ingCorrect = _newCellValue;
        break;
      case 'ingIncorrect':
        program.ingIncorrect = _newCellValue;
        break;

      case 'dinTarget':
        program.dinTarget = _newCellValue;
        break;
      case 'dinSolved':
        program.dinSolved = _newCellValue;
        break;
      case 'dinCorrect':
        program.dinCorrect = _newCellValue;
        break;
      case 'dinIncorrect':
        program.dinIncorrect = _newCellValue;
        break;
    }

    debugPrint("Switch Sonrası Program ${program.toString()}");

    _controller.changeProgram(studyProgram: program).then((value) {
      if (value != null) {
        program.id = value;
        notifyListeners();
      }
    });
  }

  Widget _buildTextFieldWidget(
      String displayText, GridColumn column, CellSubmit submitCell) {
    if (column.columnName == 'tarih' || column.columnName == 'gun') {
      return Container(
        alignment: Alignment.center,
        child: Text(
          displayText,
          style: const TextStyle(fontSize: 14, color: Colors.amber),
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: TextField(
          onChanged: (value) {
            if (value.isNotEmpty) {
              var cellValue = int.tryParse(value);
              if (cellValue != null) {
                _newCellValue = cellValue;
              }
            } else {
              _newCellValue = null;
            }
          },
          style: const TextStyle(fontSize: 14, color: Colors.white54),
          autofocus: true,
          decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.all(0)),
          textAlign: TextAlign.center,
          controller: editingController..text = displayText,
        ),
      );
    }
  }
//endregion

}

class SelectionController extends RowSelectionManager {
  SelectionController({required this.onChanged});

  //region Properties
  final ValueChanged<RowColumnIndex> onChanged;
  var _changingRow = RowColumnIndex(-1, -1);

  //endregion

  //region Overrides
  @override
  void handleKeyEvent(RawKeyEvent keyEvent) {
    super.handleKeyEvent(keyEvent);
    if (keyEvent.logicalKey.keyLabel == 'Tab') {
      super.handleKeyEvent(keyEvent);
      _changingRow.columnIndex++;
      if (_changingRow.columnIndex == 26) {
        _changingRow.rowIndex++;
        _changingRow.columnIndex = 2;
      }
      onChanged(_changingRow);
    }
  }

  @override
  void handleTap(RowColumnIndex rowColumnIndex) {
    super.handleTap(rowColumnIndex);
    rowColumnIndex.rowIndex = rowColumnIndex.rowIndex - 2;
    _changingRow = rowColumnIndex;
  }
//endregion
}
