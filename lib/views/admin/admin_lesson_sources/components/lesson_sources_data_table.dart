import 'package:flutter/material.dart';
import '../../../../models/helpers/lesson_with_subject.dart';

class LessonSourcesDataTable extends StatelessWidget {
  const LessonSourcesDataTable({Key? key, required this.resourceMap}) : super(key: key);
  final Map<String, dynamic> resourceMap;

//ANCHOR - build
  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columnList = _getDataColumnList();
    final List<DataRow> rowList = _getDataRowList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 0,
              columns: columnList,
              rows: rowList,
            ),
          ),
        ),
      ),
    );
  }

  //ANCHOR - DataColumnList
  List<DataColumn> _getDataColumnList() {
    final List<DataColumn> resourcesList = [
      const DataColumn(
          label: Text(
        'Hız Yayınları',
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 1,
      )),
      const DataColumn(
          label: Text(
        'Maraton Yayınları',
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 1,
      )),
    ];

    final List<DataColumn> columnList = [const DataColumn(label: Text('Konular')), ...resourcesList];

    return columnList;
  }

  //ANCHOR - DataRowList
  List<DataRow> _getDataRowList() {
    final lessonWithSubject = resourceMap['lessonWithSubject'] as LessonWithSubject;
    List<DataRow> rowList = [];
    if (lessonWithSubject.subjectList != null) {
      rowList = lessonWithSubject.subjectList!
          .map(
            (subject) => DataRow(
              cells: <DataCell>[
                DataCell(SizedBox(width: 150, child: Text(subject.subject ?? 'Konu'))),
                const DataCell(SizedBox(width: 80, child: Center(child: Text('h1')))),
                const DataCell(SizedBox(width: 80, child: Center(child: Text('m1')))),
              ],
            ),
          )
          .toList();
    }

    return rowList;
  }
}
