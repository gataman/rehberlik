import 'package:flutter/material.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../common/constants.dart';
import '../../../../models/lesson_source.dart';
import '../../../../models/subject.dart';

class LessonSourcesDataTable2 extends StatefulWidget {
  const LessonSourcesDataTable2({Key? key, required this.resourceMap}) : super(key: key);
  final Map<String, dynamic> resourceMap;

  @override
  State<LessonSourcesDataTable2> createState() => _LessonSourcesDataTable2State();
}

class _LessonSourcesDataTable2State extends State<LessonSourcesDataTable2> {
  List<LessonSource> resourceList = [];
  late LessonWithSubject lessonWithSubject;
//ANCHOR - build
  @override
  Widget build(BuildContext context) {
    lessonWithSubject = widget.resourceMap['lessonWithSubject'] as LessonWithSubject;
    resourceList = widget.resourceMap['lessonResourceList'] as List<LessonSource>;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lessonWithSubject.lesson.lessonName ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              _getSfDataGrid(lessonWithSubject, resourceList, context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _getSfDataGrid(LessonWithSubject lessonWithSubject, List<LessonSource> resourceList, BuildContext context) {
    final _DataSource source = _DataSource(
        lessonWithSubject: lessonWithSubject,
        sourceList: resourceList,
        onChecked: (LessonSource lessonSource) {
          debugPrint('Tıklandı: ${lessonSource.toString()}');
        });
    return SfDataGrid(
      source: source,
      columns: _getColumnList(resourceList),
      shrinkWrapRows: true,
      columnWidthMode: _getWidthMode(context),
      headerRowHeight: 30,
    );
  }

  List<GridColumn> _getColumnList(List<LessonSource> resourceList) => <GridColumn>[
        GridColumn(columnName: 'subject', label: _getLabelTitleText('Konular', true), width: 150),
        GridColumn(
          columnName: 'islenen',
          label: _getLabelTitleText('İşlenen Konular', false),
          width: 80,
        ),
        ...resourceList
            .map<GridColumn>(
              (e) => GridColumn(
                width: 80,
                columnName: 'data',
                label: _getLabelTitleText(e.sourcesName ?? '', false),
              ),
            )
            .toList(),
        GridColumn(columnName: 'add_column', label: _getLabelAddButton()),
      ];

  ColumnWidthMode _getWidthMode(BuildContext context) => ColumnWidthMode.fill;

  //Responsive.isMobile(context) ? ColumnWidthMode.none : ColumnWidthMode.fill;
  Widget _getLabelTitleText(String value, bool isFirst) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: isFirst ? Alignment.centerLeft : Alignment.center,
        child: Text(
          value,
          style: defaultDataTableTitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _getLabelAddButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            resourceList.add(LessonSource(
                studentId: '.', lessonId: lessonWithSubject.lesson.id, sourcesName: 'Yeni', subjectList: []));
          });
        },
        child: const Text('Kaynak Ekle'));
  }
}

class _DataSource extends DataGridSource {
  final LessonWithSubject lessonWithSubject;
  final List<LessonSource> sourceList;
  final Function(LessonSource lessonSource) onChecked;
  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  _DataSource({
    required this.lessonWithSubject,
    required this.sourceList,
    required this.onChecked,
  }) {
    if (lessonWithSubject.subjectList != null) {
      _dataGridRows = lessonWithSubject.subjectList!
          .map<DataGridRow>(
            (Subject sub) => DataGridRow(
              cells: [
                DataGridCell<String>(columnName: 'subject', value: sub.subject),
                const DataGridCell<Widget>(columnName: 'islenen', value: Text('...')),
                ...sourceList
                    .map<DataGridCell<Map<String, dynamic>>>((resource) => DataGridCell<Map<String, dynamic>>(
                        columnName: 'data', value: {'subjectId': sub.id, 'resource': resource}))
                    .toList(),
                const DataGridCell<String>(columnName: 'add_column', value: ''),
              ],
            ),
          )
          .toList();
    }
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    debugPrint('buildRowAdapter');
    final list = row.getCells().asMap();
    final List<Widget> cellList = [];

    list.forEach(
      (columnIndex, e) {
        if (e.columnName == 'subject' || e.columnName == 'add_column') {
          cellList.add(_getSubjectWidget(e.value));
        } else if (e.columnName == 'data') {
          final map = e.value as Map<String, dynamic>;
          final subjectId = map['subjectId'];
          final resource = map['resource'] as LessonSource;
          final isChecked = resource.subjectList!.contains(subjectId);
          final rowIndex = _dataGridRows.indexOf(row);

          cellList.add(_getCheckBoxWidget(
              subjectId: subjectId,
              resource: resource,
              isChecked: isChecked,
              rowIndex: rowIndex,
              columnIndex: columnIndex));
        } else {
          cellList.add(e.value);
        }
      },
    );
    return DataGridRowAdapter(cells: cellList);
  }

  /* row.getCells().map<Widget>((e) {
      if (e.columnName == 'subject' || e.columnName == 'add_column') {
        return _getSubjectWidget(e.value);
      } else {
        debugPrint('Gelen e: ${e}');
        return e.value;
      }
    }).toList()
    
    */

  Container _getSubjectWidget(String subjectName) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      alignment: Alignment.centerLeft,
      child: Text(
        subjectName,
        //style: _getNetTextStyle(e),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _getCheckBoxWidget(
      {required bool isChecked,
      required int rowIndex,
      required int columnIndex,
      required subjectId,
      required LessonSource resource}) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      alignment: Alignment.center,
      child: Checkbox(
        onChanged: (bool? value) {
          if (value != null && value) {
            resource.subjectList!.add(subjectId);
          } else {
            resource.subjectList!.remove(subjectId);
          }
          onChecked(resource);
          notifyDataSourceListeners(rowColumnIndex: RowColumnIndex(rowIndex, columnIndex));

          debugPrint(resource.subjectList.toString());
        },
        value: isChecked,
      ),
    );
  }
}
