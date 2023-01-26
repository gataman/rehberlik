// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/teacher.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../common/widgets/default_circular_progress.dart';
import '../../../../admin_base/cubit/teacher_cubit.dart';
import 'core/question_follow_data_source.dart';
import 'core/question_follow_selection_controller.dart';
import 'cubit/question_follow_list_cubit.dart';

class QuestionFollowListCard extends StatelessWidget {
  QuestionFollowListCard({Key? key, required this.studentID, required this.isStudent}) : super(key: key);
  DateTime? _startTime;
  final String studentID;
  final bool isStudent;

  //region Properties

  final QuestionFollowDataSource _questionFollowDataSource = QuestionFollowDataSource();

  final DataGridController _dataGridController = DataGridController();

  final String _targetLabel = "Hed";

  final String _solvedLabel = "Çöz";

  final String _correctLabel = "Doğ";

  final String _incorrectLabel = "Yan";

  //endregion
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionFollowListCubit, QuestionFollowListState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SizedBox(
            height: minimumBoxHeight,
            child: Center(child: DefaultCircularProgress()),
          );
        } else {
          if (state.questionFollowList != null) {
            _questionFollowDataSource.updateList(questionFollowList: state.questionFollowList!, context: context);
          }
          return Column(
            children: [
              if (state.questionFollowList != null) _questionFollowDataGridCard(context),
            ],
          );
        }
      },
    );
  }

  //endregion

  SfDataGrid _questionFollowDataGridCard(BuildContext context) {
    TeacherType teacherType = TeacherType.teacher;
    if (!isStudent) {
      teacherType = context.read<TeacherCubit>().teacherType;
    }

    return SfDataGrid(
        shrinkWrapRows: true,
        verticalScrollPhysics: const NeverScrollableScrollPhysics(),
        allowEditing: teacherType == TeacherType.admin || isStudent,
        frozenColumnsCount: 1,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        headerRowHeight: 30,
        defaultColumnWidth: 35,
        rowHeight: 40,
        editingGestureType: EditingGestureType.tap,
        navigationMode: GridNavigationMode.cell,
        selectionMode: SelectionMode.single,
        stackedHeaderRows: _getStackedHeaderRows(context),
        controller: _dataGridController,
        selectionManager: QuestionFollowSelectionController(onChanged: (rowIndex) {
          _dataGridController.beginEdit(rowIndex);
        }),
        source: _questionFollowDataSource,
        columns: _getColumns(context));
  }

  List<StackedHeaderRow> _getStackedHeaderRows(BuildContext context) {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(columnNames: <String>[
          'tarih',
          'gun',
        ], child: _getWidgetForStackedHeaderCell('', context)),
        StackedHeaderCell(columnNames: <String>[
          'turTarget',
          'turSolved',
          'turCorrect',
          'turIncorrect',
        ], child: _getWidgetForStackedHeaderCell('Türkçe', context)),
        StackedHeaderCell(columnNames: <String>[
          'matTarget',
          'matSolved',
          'matCorrect',
          'matIncorrect',
        ], child: _getWidgetForStackedHeaderCell('Matematik', context)),
        StackedHeaderCell(columnNames: <String>[
          'fenTarget',
          'fenSolved',
          'fenCorrect',
          'fenIncorrect',
        ], child: _getWidgetForStackedHeaderCell('Fen', context)),
        StackedHeaderCell(columnNames: <String>[
          'inkTarget',
          'inkSolved',
          'inkCorrect',
          'inkIncorrect',
        ], child: _getWidgetForStackedHeaderCell('İnkılap', context)),
        StackedHeaderCell(columnNames: <String>[
          'ingTarget',
          'ingSolved',
          'ingCorrect',
          'ingIncorrect',
        ], child: _getWidgetForStackedHeaderCell('İngilizce', context)),
        StackedHeaderCell(columnNames: <String>[
          'dinTarget',
          'dinSolved',
          'dinCorrect',
          'dinIncorrect',
        ], child: _getWidgetForStackedHeaderCell('Din', context)),
      ])
    ];
    return stackedHeaderRows;
  }

  Widget _getWidgetForStackedHeaderCell(String title, BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ));
  }

  List<GridColumn> _getColumns(BuildContext context) {
    return <GridColumn>[
      GridColumn(width: 100, columnName: 'tarih', label: _getLabelDateTitleText(context, "Tarih"), allowEditing: false),
      GridColumn(width: 100, columnName: 'gun', label: _getLabelTitleText("Gün", context), allowEditing: false),
      GridColumn(columnName: 'turTarget', label: _getLabelTitleText(_targetLabel, context)),
      GridColumn(columnName: 'turSolved', label: _getLabelTitleText(_solvedLabel, context)),
      GridColumn(columnName: 'turCorrect', label: _getLabelTitleText(_correctLabel, context)),
      GridColumn(columnName: 'turIncorrect', label: _getLabelTitleText(_incorrectLabel, context)),
      GridColumn(columnName: 'matTarget', label: _getLabelTitleText(_targetLabel, context)),
      GridColumn(columnName: 'matSolved', label: _getLabelTitleText(_solvedLabel, context)),
      GridColumn(columnName: 'matCorrect', label: _getLabelTitleText(_correctLabel, context)),
      GridColumn(columnName: 'matIncorrect', label: _getLabelTitleText(_incorrectLabel, context)),
      GridColumn(columnName: 'fenTarget', label: _getLabelTitleText(_targetLabel, context)),
      GridColumn(columnName: 'fenSolved', label: _getLabelTitleText(_solvedLabel, context)),
      GridColumn(columnName: 'fenCorrect', label: _getLabelTitleText(_correctLabel, context)),
      GridColumn(columnName: 'fenIncorrect', label: _getLabelTitleText(_incorrectLabel, context)),
      GridColumn(columnName: 'inkTarget', label: _getLabelTitleText(_targetLabel, context)),
      GridColumn(columnName: 'inkSolved', label: _getLabelTitleText(_solvedLabel, context)),
      GridColumn(columnName: 'inkCorrect', label: _getLabelTitleText(_correctLabel, context)),
      GridColumn(columnName: 'inkIncorrect', label: _getLabelTitleText(_incorrectLabel, context)),
      GridColumn(columnName: 'ingTarget', label: _getLabelTitleText(_targetLabel, context)),
      GridColumn(columnName: 'ingSolved', label: _getLabelTitleText(_solvedLabel, context)),
      GridColumn(columnName: 'ingCorrect', label: _getLabelTitleText(_correctLabel, context)),
      GridColumn(columnName: 'ingIncorrect', label: _getLabelTitleText(_incorrectLabel, context)),
      GridColumn(columnName: 'dinTarget', label: _getLabelTitleText(_targetLabel, context)),
      GridColumn(columnName: 'dinSolved', label: _getLabelTitleText(_solvedLabel, context)),
      GridColumn(columnName: 'dinCorrect', label: _getLabelTitleText(_correctLabel, context)),
      GridColumn(columnName: 'dinIncorrect', label: _getLabelTitleText(_incorrectLabel, context)),
    ];
  }

  Widget _getLabelTitleText(String value, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        value,
        style: Theme.of(context).textTheme.labelMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _getLabelDateTitleText(BuildContext context, String value) {
    return TextButton(
      onPressed: () async {
        await _pickDate(context).then((newDate) {
          if (newDate != null) {
            context.read<QuestionFollowListCubit>().fetchQuestionFollowList(studentID: studentID, startTime: newDate);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                value,
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.date_range_outlined,
              color: Theme.of(context).colorScheme.secondary,
              size: 16,
            )
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    if (_startTime == null) {
      final dateNow = DateTime.now();
      _startTime = DateTime(dateNow.year, dateNow.month, dateNow.day);
    }
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _startTime!,
      firstDate: DateTime(2018),
      lastDate: DateTime(2035),
    );

    return newDate;
  }
}
