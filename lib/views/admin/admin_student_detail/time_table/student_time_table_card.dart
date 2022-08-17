import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/helper.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/models/subject.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:rehberlik/views/admin/admin_student_detail/time_table/student_time_table_add_dialog.dart';
import 'package:rehberlik/views/admin/admin_student_detail/time_table/student_time_table_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StudentTimeTableCard extends StatefulWidget {
  final Student student;

  const StudentTimeTableCard({Key? key, required this.student})
      : super(key: key);

  @override
  State<StudentTimeTableCard> createState() => _StudentTimeTableCardState();
}

class _StudentTimeTableCardState extends State<StudentTimeTableCard> {
  final _controller = Get.put(StudentTimeTableController());

  final TimeTableDataSource _timeTableDataSource = TimeTableDataSource();

  @override
  void initState() {
    _controller.getAllTimeTable(student: widget.student).then((value) {
      debugPrint("Gelen Liste: ${value.toString()}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.timeTableList.value != null) {
        _timeTableDataSource.updateList(
            timeTableMap: _controller.timeTableList.value!, context: context);
        return Column(
          children: [
            SizedBox(
              height: 350,
              child: _timeTableDataGridCard(),
            ),
          ],
        );
      } else {
        return const DefaultCircularProgress();
      }
    });
  }

  SfDataGrid _timeTableDataGridCard() {
    return SfDataGrid(
        shrinkWrapRows: true,
        verticalScrollPhysics: const NeverScrollableScrollPhysics(),
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        headerRowHeight: 30,
        defaultColumnWidth: 50,
        rowHeight: 80,
        source: _timeTableDataSource,
        columns: _getColumns());
  }

  List<GridColumn> _getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'monday',
          label: _getLabelTitleText("Pazartesi"),
          width: 100),
      GridColumn(
          columnName: 'tuesday', label: _getLabelTitleText("Salı"), width: 100),
      GridColumn(
          columnName: 'wednesday',
          label: _getLabelTitleText("Çarşamba"),
          width: 100),
      GridColumn(
          columnName: 'thursday',
          label: _getLabelTitleText("Perşembe"),
          width: 100),
      GridColumn(
          columnName: 'friday', label: _getLabelTitleText("Cuma"), width: 100),
      GridColumn(
          columnName: 'saturday',
          label: _getLabelTitleText("Cumartesi"),
          width: 100),
      GridColumn(
          columnName: 'sunday', label: _getLabelTitleText("Pazar"), width: 100)
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

class TimeTableDataSource extends DataGridSource {
  final _controller = Get.put(StudentTimeTableController());
  //final Map<int, List<TimeTable>> _timeTableList = {};
  final List<DataGridRow> _timeTableDataGridRows = [];
  BuildContext? _context;

  @override
  List<DataGridRow> get rows => _timeTableDataGridRows;

  void updateList(
      {required BuildContext context,
      required Map<int, List<TimeTable>> timeTableMap}) async {
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
                      style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Text(
                      _getSubjectName(
                          lessonID: timeTable.lessonID,
                          subjectID: timeTable.subjectID),
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
              debugPrint("Ders eklenme");
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

  String _getLessonNameText({String? lessonID}) {
    final _lessonList = _controller.lessonWithSubjectList;
    if (lessonID != null) {
      LessonWithSubject? lessonWithSubject = _lessonList
          .firstWhereOrNull((element) => element.lesson.id == lessonID);
      if (lessonWithSubject != null) {
        return lessonWithSubject.lesson.lessonName!;
      }
    }
    return "";
  }

  String _getSubjectName(
      {required String? lessonID, required String? subjectID}) {
    final _lessonList = _controller.lessonWithSubjectList;
    if (lessonID != null) {
      LessonWithSubject? lessonWithSubject = _lessonList
          .firstWhereOrNull((element) => element.lesson.id == lessonID);
      if (lessonWithSubject != null) {
        if (lessonWithSubject.subjectList != null) {
          Subject? subject = lessonWithSubject.subjectList!
              .firstWhereOrNull((subject) => subject.id == subjectID);
          if (subject != null) {
            return subject.subject!;
          }
        }
      }
    }
    return "";
  }
}
