part of student_detail_tab_view;

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
              SizedBox(
                height: 350,
                child: _timeTableDataGridCard(),
              ),
            ],
          );
        } else {
          return const DefaultCircularProgress();
        }
      }
    });
  }

  SfDataGrid _timeTableDataGridCard() {
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
        columns: _getColumns());
  }

  List<GridColumn> _getColumns() {
    /*
    double width =
        _detailController.isExpanded.value && !Responsive.isMobile(context)
            ? double.nan
            : 100;

     */
    double width = 100;
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
