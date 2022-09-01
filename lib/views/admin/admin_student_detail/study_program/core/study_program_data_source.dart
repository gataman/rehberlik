import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rehberlik/models/study_program.dart';
import 'package:rehberlik/views/admin/admin_student_detail/study_program/admin_study_program_controller.dart';
import 'package:rehberlik/views/admin/admin_student_detail/study_program/cubit/study_program_list_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class StudyProgramDataSource extends DataGridSource {
  //region Properties
  List<DataGridRow> _programsDataGridRows = [];
  BuildContext? _context;
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
        DataGridCell<int>(columnName: column.columnName, value: _newCellValue);

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
  void updateList(
      {required List<StudyProgram> programList,
      required BuildContext context}) {
    _context = context;
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
    }
    notifyListeners();
  }

  void _chageProgramValue(
      {required StudyProgram program, required String columnName}) {
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

    if (_context != null) {
      _context!
          .read<StudyProgramListCubit>()
          .changeProgram(studyProgram: program)
          .then((value) {
        if (value != null) {
          program.id = value;
          notifyListeners();
        }
      });
    }
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
          onSubmitted: (value) {
            submitCell();
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
