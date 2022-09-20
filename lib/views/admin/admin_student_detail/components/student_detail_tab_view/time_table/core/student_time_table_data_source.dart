import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../../core/widgets/containers/app_time_table_card_item.dart';
import '../../../../../../../models/time_table.dart';
import '../cubit/time_table_list_cubit.dart';
import '../student_time_table_add_dialog.dart';

class StudentTimeTableDataSource extends DataGridSource {
  //final Map<int, List<TimeTable>> _timeTableList = {};
  final List<DataGridRow> _timeTableDataGridRows = [];
  BuildContext? _context;

  @override
  List<DataGridRow> get rows => _timeTableDataGridRows;

  void updateList({required BuildContext context, required Map<int, List<TimeTable>> timeTableMap}) async {
    timeTableMap.forEach((key, timeTableList) {
      _context = context;
      final cells = <DataGridCell<TimeTable>>[];
      var day = 1;
      for (var timeTable in timeTableList) {
        var columnName = _getColumnName(day);
        final cell = DataGridCell(columnName: columnName, value: timeTable);
        cells.add(cell);
        day++;
      }

      final dataGridRow = DataGridRow(cells: cells);
      _timeTableDataGridRows.add(dataGridRow);
    });

    notifyListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      final timeTable = e.value as TimeTable;
      return AppTimeTableCardItem(
          onTap: () {
            if (_context != null) {
              showDialog(
                  //barrierDismissible: false,
                  context: _context!,
                  builder: (BuildContext context) {
                    TimeTableListCubit cubit = _context!.read<TimeTableListCubit>();
                    return TimeTableAddAlertDialog(timeTable: timeTable, cubit: cubit);
                  });

              debugPrint("Tıklanan Time table ${timeTable.toString()}");
            } else {
              debugPrint("Context null");
            }
          },
          timeTable: timeTable);
    }).toList());
  }

  String _getColumnName(int day) {
    switch (day) {
      case 2:
        return 'tuesday';
      case 3:
        return 'wednesday';
      case 4:
        return 'thursday';
      case 5:
        return 'friday';
      case 6:
        return 'saturday';
      case 7:
        return 'sunday';
      default:
        return 'monday';
    }
  }

  /*
  Widget _getTimeDropDownMenu(int time) {
    final timeList = <String>[
      "17.00 - 18.00",
      "18.00 - 19.00",
      "19.00 - 20.00",
      "21.00 - 22.00"
    ];

    return DropdownButton(
        elevation: 0,
        iconSize: 14,
        isDense: true,
        underline: Container(color: Colors.transparent),
        items: timeList.map((String item) {
          return DropdownMenuItem(
            child: Text(
              item.toString(),
              style: const TextStyle(fontSize: 10),
            ),
            value: item.toString(),
          );
        }).toList(),
        value: timeList[time],
        onChanged: (value) {});
  }

   */

}

/*
  if (timeTable.lessonID != null) {
        return GestureDetector(
          onTap: () {
            _controller.selectedTimeTable.value = timeTable;
            if (_context != null) {
              var dialog = StudentTimeTableAddDialog(_controller);
              dialog.showNewTimeTableDialog(_context!);
            }
          },
          child: AbsorbPointer(
            child: Container(
              alignment: Alignment.center,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${Helper.getTimeDayText(timeTable.startTime)} - ${Helper.getTimeDayText(timeTable.endTime)}",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      _getLessonNameText(lessonID: timeTable.lessonID),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    Text(
                      _getSubjectName(lessonID: timeTable.lessonID, subjectID: timeTable.subjectID),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white54,
                        letterSpacing: 0.3,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return GestureDetector(
            onTap: () {
              _controller.selectedTimeTable.value = timeTable;
              if (_context != null) {
                var dialog = StudentTimeTableAddDialog(_controller);
                dialog.showNewTimeTableDialog(_context!);
              }
            },
            child: const SizedBox(
              width: 100,
              child: Text(""),
            ));
      }
 */
