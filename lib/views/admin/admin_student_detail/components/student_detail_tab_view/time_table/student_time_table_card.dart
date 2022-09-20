import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/responsive.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../common/constants.dart';
import '../../../../../../common/widgets/default_circular_progress.dart';
import '../../../../../../models/student.dart';
import '../../../../admin_base/cubit/expanded_cubit.dart';
import 'core/student_time_table_data_source.dart';
import 'cubit/time_table_list_cubit.dart';

class StudentTimeTableCard extends StatelessWidget {
  final Student student;
  final StudentTimeTableDataSource _timeTableDataSource = StudentTimeTableDataSource();

  StudentTimeTableCard({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeTableListCubit, TimeTableListState>(builder: (context, state) {
      if (state.isLoading) {
        return const SizedBox(
          height: minimumBoxHeight,
          child: Center(child: DefaultCircularProgress()),
        );
      } else {
        if (state.timeTableList != null) {
          _timeTableDataSource.updateList(timeTableMap: state.timeTableList!, context: context);
          return Column(
            children: [
              Container(
                height: 350,
                decoration: tableBoxDecoration,
                child: _timeTableDataGridCard(context),
              ),
            ],
          );
        } else {
          return const DefaultCircularProgress();
        }
      }
    });
  }

  Widget _timeTableDataGridCard(BuildContext context) {
    return BlocBuilder<ExpandedCubit, ExpandedState>(
      builder: (context, state) {
        return SfDataGrid(
            shrinkWrapRows: true,
            verticalScrollPhysics: const NeverScrollableScrollPhysics(),
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            columnWidthMode: ColumnWidthMode.fill,
            headerRowHeight: 30,
            defaultColumnWidth: 50,
            rowHeight: 80,
            source: _timeTableDataSource,
            columns: _getColumns(state.isExpanded, context));
      },
    );
  }

  List<GridColumn> _getColumns(bool isExpanded, BuildContext context) {
    double width = !Responsive.isMobile(context) ? double.nan : 100;

    return <GridColumn>[
      GridColumn(columnName: 'monday', label: _getLabelTitleText("Pazartesi"), width: width),
      GridColumn(columnName: 'tuesday', label: _getLabelTitleText("Salı"), width: width),
      GridColumn(columnName: 'wednesday', label: _getLabelTitleText("Çarşamba"), width: width),
      GridColumn(columnName: 'thursday', label: _getLabelTitleText("Perşembe"), width: width),
      GridColumn(columnName: 'friday', label: _getLabelTitleText("Cuma"), width: width),
      GridColumn(columnName: 'saturday', label: _getLabelTitleText("Cumartesi"), width: width),
      GridColumn(columnName: 'sunday', label: _getLabelTitleText("Pazar"), width: width)
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
