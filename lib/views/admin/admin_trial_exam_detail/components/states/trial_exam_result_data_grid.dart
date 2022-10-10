part of admin_trial_exam_result_view;

class TrialExamResultDataGrid extends StatefulWidget {
  const TrialExamResultDataGrid({Key? key, required this.trialExamResultList}) : super(key: key);

  final List<TrialExamResult> trialExamResultList;

  @override
  State<TrialExamResultDataGrid> createState() => _TrialExamResultDataGridState();
}

class _TrialExamResultDataGridState extends State<TrialExamResultDataGrid> {
  final String _dogruLabel = "Doğ";
  final String _netLabel = "Net";
  final String _pointLabel = "Puan";
  final String _schoolRankLabel = "Okul";
  final String _classRankLabel = "Sınıf";
  final String _yanlisLabel = "Yan";
  int _rowsPerPage = 15;

  late TrialExamResultDataSource _trialExamResultDataSource;
  late List<TrialExamResult> _trialExamResultList;

  @override
  void initState() {
    _trialExamResultList = widget.trialExamResultList;
    _trialExamResultDataSource = TrialExamResultDataSource(trialExamResultList: _trialExamResultList);

    /// Programmaticaly sorting based on string length for 'customer name' GirdColumn
    _sortColumns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder(
            future: _getTrialExamDataGrid(widget.trialExamResultList),
            builder: (context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.hasData) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _detailButton(context),
                      snapshot.data!, // DatGridWİdget
                      _buildDataPager(),
                    ],
                  ),
                );
              } else {
                return const SizedBox(
                    height: minimumBoxHeight,
                    child: Center(
                      child: DefaultCircularProgress(),
                    ));
              }
            },
          ),
        ],
      ),
    );
  }

  ElevatedButton _detailButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<TrialExamResultCubit>().showTrialExamStatics();
        //context.read<TrialExamResultCubit>().calculateAllStudentRanks(8);
      },
      style: ElevatedButton.styleFrom(
        shape: const BeveledRectangleBorder(),
      ),
      child: Text(
        'Detaylı İstatistikler',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  Future<Widget> _getTrialExamDataGrid(List<TrialExamResult> trialExamResultList) async {
    //subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    await Future.delayed(const Duration(seconds: 1));

    return SizedBox(
      height: 450,
      child: SfDataGrid(
        allowSorting: true,
        columnWidthMode: _getWidthMode(),
        frozenColumnsCount: 3,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        headerRowHeight: 30,
        defaultColumnWidth: Responsive.isMobile(context) ? 35 : double.nan,
        rowHeight: 40,
        //rowsPerPage: _rowsPerPage,
        //footerFrozenRowsCount: 1,
        //footer: _getFooter(),
        stackedHeaderRows: _getStackedHeaderRows(),
        source: _trialExamResultDataSource,
        columns: _getColumns(),
      ),
    );
  }

  List<StackedHeaderRow> _getStackedHeaderRows() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(
            columnNames: <String>['student_no', 'student_name', 'student_class'],
            child: _getWidgetForStackedHeaderCell('')),
        StackedHeaderCell(columnNames: <String>[
          'turDog',
          'turYan',
          'turNet',
        ], child: _getWidgetForStackedHeaderCell('Türkçe')),
        StackedHeaderCell(columnNames: <String>[
          'matDog',
          'matYan',
          'matNet',
        ], child: _getWidgetForStackedHeaderCell('Matematik')),
        StackedHeaderCell(columnNames: <String>[
          'fenDog',
          'fenYan',
          'fenNet',
        ], child: _getWidgetForStackedHeaderCell('Fen')),
        StackedHeaderCell(columnNames: <String>[
          'sosDog',
          'sosYan',
          'sosNet',
        ], child: _getWidgetForStackedHeaderCell('Sosyal')),
        StackedHeaderCell(columnNames: <String>[
          'ingDog',
          'ingYan',
          'ingNet',
        ], child: _getWidgetForStackedHeaderCell('İngilizce')),
        StackedHeaderCell(columnNames: <String>[
          'dinDog',
          'dinYan',
          'dinNet',
        ], child: _getWidgetForStackedHeaderCell('Din')),
        StackedHeaderCell(columnNames: <String>[
          'topDog',
          'topYan',
          'topNet',
          'classRank',
          'schoolRank',
          'totalPoint',
        ], child: _getWidgetForStackedHeaderCell('Toplam')),
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

  List<GridColumn> _getColumns() {
    return <GridColumn>[
      GridColumn(
        columnName: 'student_no',
        label: _getLabelTitleText("No"),
      ),
      GridColumn(
        width: Responsive.isMobile(context) ? 100 : 150,
        columnName: 'student_name',
        label: _getLabelTitleText("Öğrenci Adı"),
      ),
      GridColumn(
        columnName: 'student_class',
        label: _getLabelTitleText("Sınıfı"),
      ),
      GridColumn(columnName: 'turDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'turYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'turNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'matDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'matYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'matNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'fenDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'fenYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'fenNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'sosDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'sosYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'sosNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'ingDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'ingYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'ingNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'dinDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'dinYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'dinNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'topDog', label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'topYan', label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'topNet', label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'classRank', label: _getLabelTitleText(_classRankLabel)),
      GridColumn(columnName: 'schoolRank', label: _getLabelTitleText(_schoolRankLabel)),
      GridColumn(columnName: 'totalPoint', label: _getLabelTitleText(_pointLabel), width: 60),
    ];
  }

  Widget _buildDataPager() {
    var pageCount = _trialExamResultList.length / _rowsPerPage;
    if (pageCount % _rowsPerPage != 0) {
      pageCount = pageCount + 1;
    }
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        brightness: Brightness.dark,
        selectedItemColor: Colors.amber,
      ),
      child: SfDataPager(
        delegate: _trialExamResultDataSource,
        availableRowsPerPage: const <int>[15, 20, 25],
        pageCount: pageCount,
        onRowsPerPageChanged: (int? rowsPerPage) {
          setState(() {
            _rowsPerPage = rowsPerPage!;
          });
        },
      ),
    );
  }

  ColumnWidthMode _getWidthMode() => Responsive.isMobile(context) ? ColumnWidthMode.none : ColumnWidthMode.fill;

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

  void _sortColumns() {
    _trialExamResultDataSource.sortedColumns
        .add(const SortColumnDetails(name: 'totalPoint', sortDirection: DataGridSortDirection.descending));
    _trialExamResultDataSource.sort();
  }
}
