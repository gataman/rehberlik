import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../common/widgets/default_circular_progress.dart';
import 'core/question_follow_data_source.dart';
import 'core/question_follow_selection_controller.dart';
import 'cubit/question_follow_list_cubit.dart';

class QuestionFollowListCard extends StatelessWidget {
  QuestionFollowListCard({Key? key, required this.studentID}) : super(key: key);
  DateTime? _startTime;
  final String studentID;

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
          if (state.quuestionFollowList != null) {
            _questionFollowDataSource.updateList(questionFollowList: state.quuestionFollowList!, context: context);
          }
          return Column(
            children: [
              if (state.quuestionFollowList != null) _questionFollowDataGridCard(context),
            ],
          );
        }
      },
    );
  }

  //endregion

  SfDataGrid _questionFollowDataGridCard(BuildContext context) {
    return SfDataGrid(
        shrinkWrapRows: true,
        verticalScrollPhysics: const NeverScrollableScrollPhysics(),
        allowEditing: true,
        frozenColumnsCount: 1,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        headerRowHeight: 30,
        defaultColumnWidth: 35,
        rowHeight: 40,
        editingGestureType: EditingGestureType.tap,
        navigationMode: GridNavigationMode.cell,
        selectionMode: SelectionMode.single,
        stackedHeaderRows: _getStackedHeaderRows(),
        controller: _dataGridController,
        selectionManager: QuestionFollowSelectionController(onChanged: (_rowIndex) {
          _dataGridController.beginEdit(_rowIndex);
        }),
        source: _questionFollowDataSource,
        columns: _getColumns(context));
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
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.amber),
        ));
  }

  List<GridColumn> _getColumns(BuildContext context) {
    return <GridColumn>[
      GridColumn(width: 100, columnName: 'tarih', label: _getLabelDateTitleText(context, "Tarih"), allowEditing: false),
      GridColumn(width: 100, columnName: 'gun', label: _getLabelTitleText("Gün"), allowEditing: false),
      GridColumn(columnName: 'turTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(columnName: 'turSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(columnName: 'turCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(columnName: 'turIncorrect', label: _getLabelTitleText(_incorrectLabel)),
      GridColumn(columnName: 'matTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(columnName: 'matSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(columnName: 'matCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(columnName: 'matIncorrect', label: _getLabelTitleText(_incorrectLabel)),
      GridColumn(columnName: 'fenTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(columnName: 'fenSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(columnName: 'fenCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(columnName: 'fenIncorrect', label: _getLabelTitleText(_incorrectLabel)),
      GridColumn(columnName: 'inkTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(columnName: 'inkSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(columnName: 'inkCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(columnName: 'inkIncorrect', label: _getLabelTitleText(_incorrectLabel)),
      GridColumn(columnName: 'ingTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(columnName: 'ingSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(columnName: 'ingCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(columnName: 'ingIncorrect', label: _getLabelTitleText(_incorrectLabel)),
      GridColumn(columnName: 'dinTarget', label: _getLabelTitleText(_targetLabel)),
      GridColumn(columnName: 'dinSolved', label: _getLabelTitleText(_solvedLabel)),
      GridColumn(columnName: 'dinCorrect', label: _getLabelTitleText(_correctLabel)),
      GridColumn(columnName: 'dinIncorrect', label: _getLabelTitleText(_incorrectLabel)),
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
                style: defaultDataTableTitleStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.date_range_outlined,
              color: Colors.teal,
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
