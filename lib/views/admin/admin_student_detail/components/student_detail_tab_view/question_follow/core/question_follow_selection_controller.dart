import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class QuestionFollowSelectionController extends RowSelectionManager {
  QuestionFollowSelectionController({required this.onChanged});

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
