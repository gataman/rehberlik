import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../../common/extensions.dart';
import '../../../../../../../models/question_follow.dart';
import '../cubit/question_follow_list_cubit.dart';

class QuestionFollowDataSource extends DataGridSource {
  //region Properties
  List<DataGridRow> _questionFollowDataGridRows = [];
  BuildContext? _context;
  List<QuestionFollow> _questionFollowList = [];
  TextEditingController editingController = TextEditingController();
  dynamic _newCellValue;

  //endregion

  //region Overrides
  @override
  List<DataGridRow> get rows => _questionFollowDataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
          alignment: Alignment.center,
          child: Text(e.value == null ? '  ' : e.value.toString(),
              style: (e.columnName == 'tarih' || e.columnName == 'gun')
                  ? Theme.of(_context!).textTheme.titleMedium
                  : Theme.of(_context!).textTheme.bodyMedium));
    }).toList());
  }

  @override
  bool onCellBeginEdit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    final dynamic oldValue = dataGridRow
        .getCells()
        .findOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
        ?.value;

    _newCellValue = oldValue;
    return super.onCellBeginEdit(dataGridRow, rowColumnIndex, column);
  }

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    final dynamic oldValue = dataGridRow
        .getCells()
        .findOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
        ?.value;

    final int dataRowIndex = _questionFollowDataGridRows.indexOf(dataGridRow);

    if (oldValue == _newCellValue) {
      return;
    }

    _questionFollowDataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
        DataGridCell<int>(columnName: column.columnName, value: _newCellValue);

    _chageQuestionFollowValue(
        questionFollow: _questionFollowList[rowColumnIndex.rowIndex], columnName: column.columnName);
  }

  @override
  Widget? buildEditWidget(
      DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    final String displayText = dataGridRow
            .getCells()
            .findOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    return _buildTextFieldWidget(displayText, column, submitCell);
  }

  //endregion

  //region Methods
  void updateList({required List<QuestionFollow> questionFollowList, required BuildContext context}) {
    _context = context;
    if (questionFollowList.isNotEmpty) {
      _questionFollowList = questionFollowList;
      _questionFollowDataGridRows = questionFollowList
          .map(
            (e) => DataGridRow(
              cells: [
                DataGridCell<String>(columnName: 'tarih', value: DateFormat("dd.MM.yyyy").format(e.date!)),
                DataGridCell<String>(columnName: 'gun', value: DateFormat("EEEE", 'tr').format(e.date!)),
                DataGridCell<int>(columnName: 'turTarget', value: e.turTarget),
                DataGridCell<int>(columnName: 'turSolved', value: e.turSolved),
                DataGridCell<int>(columnName: 'turCorrect', value: e.turCorrect),
                DataGridCell<int>(columnName: 'turIncorrect', value: e.turIncorrect),
                DataGridCell<int>(columnName: 'matTarget', value: e.matTarget),
                DataGridCell<int>(columnName: 'matSolved', value: e.matSolved),
                DataGridCell<int>(columnName: 'matCorrect', value: e.matCorrect),
                DataGridCell<int>(columnName: 'matIncorrect', value: e.matIncorrect),
                DataGridCell<int>(columnName: 'fenTarget', value: e.fenTarget),
                DataGridCell<int>(columnName: 'fenSolved', value: e.fenSolved),
                DataGridCell<int>(columnName: 'fenCorrect', value: e.fenCorrect),
                DataGridCell<int>(columnName: 'fenIncorrect', value: e.fenIncorrect),
                DataGridCell<int>(columnName: 'inkTarget', value: e.inkTarget),
                DataGridCell<int>(columnName: 'inkSolved', value: e.inkSolved),
                DataGridCell<int>(columnName: 'inkCorrect', value: e.inkCorrect),
                DataGridCell<int>(columnName: 'inkIncorrect', value: e.inkIncorrect),
                DataGridCell<int>(columnName: 'ingTarget', value: e.ingTarget),
                DataGridCell<int>(columnName: 'ingSolved', value: e.ingSolved),
                DataGridCell<int>(columnName: 'ingCorrect', value: e.ingCorrect),
                DataGridCell<int>(columnName: 'ingIncorrect', value: e.ingIncorrect),
                DataGridCell<int>(columnName: 'dinTarget', value: e.dinTarget),
                DataGridCell<int>(columnName: 'dinSolved', value: e.dinSolved),
                DataGridCell<int>(columnName: 'dinCorrect', value: e.dinCorrect),
                DataGridCell<int>(columnName: 'dinIncorrect', value: e.dinIncorrect),
              ],
            ),
          )
          .toList();
    }
    notifyListeners();
  }

  void _chageQuestionFollowValue({required QuestionFollow questionFollow, required String columnName}) {
    switch (columnName) {
      case 'turTarget':
        questionFollow.turTarget = _newCellValue;
        break;
      case 'turSolved':
        questionFollow.turSolved = _newCellValue;
        break;
      case 'turCorrect':
        questionFollow.turCorrect = _newCellValue;
        break;
      case 'turIncorrect':
        questionFollow.turIncorrect = _newCellValue;
        break;

      case 'matTarget':
        questionFollow.matTarget = _newCellValue;
        break;
      case 'matSolved':
        questionFollow.matSolved = _newCellValue;
        break;
      case 'matCorrect':
        questionFollow.matCorrect = _newCellValue;
        break;
      case 'matIncorrect':
        questionFollow.matIncorrect = _newCellValue;
        break;

      case 'fenTarget':
        questionFollow.fenTarget = _newCellValue;
        break;
      case 'fenSolved':
        questionFollow.fenSolved = _newCellValue;
        break;
      case 'fenCorrect':
        questionFollow.fenCorrect = _newCellValue;
        break;
      case 'fenIncorrect':
        questionFollow.fenIncorrect = _newCellValue;
        break;

      case 'inkTarget':
        questionFollow.inkTarget = _newCellValue;
        break;
      case 'inkSolved':
        questionFollow.inkSolved = _newCellValue;
        break;
      case 'inkCorrect':
        questionFollow.inkCorrect = _newCellValue;
        break;
      case 'inkIncorrect':
        questionFollow.inkIncorrect = _newCellValue;
        break;

      case 'ingTarget':
        questionFollow.ingTarget = _newCellValue;
        break;
      case 'ingSolved':
        questionFollow.ingSolved = _newCellValue;
        break;
      case 'ingCorrect':
        questionFollow.ingCorrect = _newCellValue;
        break;
      case 'ingIncorrect':
        questionFollow.ingIncorrect = _newCellValue;
        break;

      case 'dinTarget':
        questionFollow.dinTarget = _newCellValue;
        break;
      case 'dinSolved':
        questionFollow.dinSolved = _newCellValue;
        break;
      case 'dinCorrect':
        questionFollow.dinCorrect = _newCellValue;
        break;
      case 'dinIncorrect':
        questionFollow.dinIncorrect = _newCellValue;
        break;
    }

    if (_context != null) {
      _context!.read<QuestionFollowListCubit>().changeQuestionFollow(questionFollow: questionFollow).then((value) {
        if (value != null) {
          questionFollow.id = value;
          notifyListeners();
        }
      });
    }
  }

  Widget _buildTextFieldWidget(String displayText, GridColumn column, CellSubmit submitCell) {
    if (column.columnName == 'tarih' || column.columnName == 'gun') {
      return Container(
        alignment: Alignment.center,
        child: Text(
          displayText,
          style: TextStyle(fontSize: 14, color: Theme.of(_context!).colorScheme.primary),
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
          style: Theme.of(_context!).textTheme.bodyLarge,
          autofocus: true,
          decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.all(0)),
          textAlign: TextAlign.center,
          controller: editingController..text = displayText,
        ),
      );
    }
  }
//endregion
}
