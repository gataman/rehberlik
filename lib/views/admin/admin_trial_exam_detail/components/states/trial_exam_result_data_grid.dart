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
  int _rowsPerPage = 15;
  late TrialExamResultDataSource _trialExamResultDataSource;
  late List<TrialExamResult> _trialExamResultList;
  final String _yanlisLabel = "Yan";

  @override
  void initState() {
    _trialExamResultList = widget.trialExamResultList;
    _trialExamResultDataSource = TrialExamResultDataSource(trialExamResultList: _trialExamResultList);
    super.initState();
  }

  Widget _getTrialExamDataGrid(List<TrialExamResult> trialExamResultList) {
    //subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
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

  Table _getFooter() {
    final trialExamAverage = TrialExamAverage(
        turDog: 1,
        turYan: 2,
        turNet: 3,
        matDog: 4,
        matYan: 5,
        matNet: 6,
        fenDog: 7,
        fenYan: 8,
        fenNet: 9,
        sosDog: 10,
        sosYan: 11,
        sosNet: 12,
        ingDog: 13,
        ingYan: 14,
        ingNet: 15,
        dinDog: 16,
        dinYan: 17,
        dinNet: 18,
        topDog: 19,
        topYan: 29,
        topNet: 21);
    return Table(
      border: TableBorder.all(),
      children: <TableRow>[
        TableRow(children: [
          const TableCell(
            child: Text(''),
          ),
          const TableCell(child: Text('Ortalama')),
          const TableCell(child: Text('')),
          TableCell(child: Text(trialExamAverage.turDog.toString())),
          TableCell(child: Text(trialExamAverage.turYan.toString())),
          TableCell(child: Text(trialExamAverage.turNet.toString())),
          TableCell(child: Text(trialExamAverage.matDog.toString())),
          TableCell(child: Text(trialExamAverage.matYan.toString())),
          TableCell(child: Text(trialExamAverage.matNet.toString())),
          TableCell(child: Text(trialExamAverage.fenDog.toString())),
          TableCell(child: Text(trialExamAverage.fenYan.toString())),
          TableCell(child: Text(trialExamAverage.fenNet.toString())),
          TableCell(child: Text(trialExamAverage.sosDog.toString())),
          TableCell(child: Text(trialExamAverage.sosYan.toString())),
          TableCell(child: Text(trialExamAverage.sosNet.toString())),
          TableCell(child: Text(trialExamAverage.ingDog.toString())),
          TableCell(child: Text(trialExamAverage.ingYan.toString())),
          TableCell(child: Text(trialExamAverage.ingNet.toString())),
          TableCell(child: Text(trialExamAverage.dinDog.toString())),
          TableCell(child: Text(trialExamAverage.dinYan.toString())),
          TableCell(child: Text(trialExamAverage.dinNet.toString())),
          TableCell(child: Text(trialExamAverage.topDog.toString())),
          TableCell(child: Text(trialExamAverage.topYan.toString())),
          TableCell(child: Text(trialExamAverage.topNet.toString())),
        ])
      ],
    );
    /*
    return DataGridRow(
      cells: [

        DataGridCell<String>(columnName: 'student_no', value: ''),
        DataGridCell<String>(columnName: 'student_name', value: 'Ortalama'),
        DataGridCell<String>(columnName: 'student_class', value: ''),
        DataGridCell<double>(columnName: 'turDog', value: trialExamAverage.turDog),
        DataGridCell<double>(columnName: 'turYan', value: trialExamAverage.turYan),
        DataGridCell<double>(columnName: 'turNet', value: trialExamAverage.turNet),
        DataGridCell<double>(columnName: 'matDog', value: trialExamAverage.matDog),
        DataGridCell<double>(columnName: 'matYan', value: trialExamAverage.matYan),
        DataGridCell<double>(columnName: 'matNet', value: trialExamAverage.matNet),
        DataGridCell<double>(columnName: 'fenDog', value: trialExamAverage.fenDog),
        DataGridCell<double>(columnName: 'fenYan', value: trialExamAverage.fenYan),
        DataGridCell<double>(columnName: 'fenNet', value: trialExamAverage.fenNet),
        DataGridCell<double>(columnName: 'sosDog', value: trialExamAverage.sosDog),
        DataGridCell<double>(columnName: 'sosYan', value: trialExamAverage.sosYan),
        DataGridCell<double>(columnName: 'sosNet', value: trialExamAverage.sosNet),
        DataGridCell<double>(columnName: 'ingDog', value: trialExamAverage.ingDog),
        DataGridCell<double>(columnName: 'ingYan', value: trialExamAverage.ingYan),
        DataGridCell<double>(columnName: 'ingNet', value: trialExamAverage.ingNet),
        DataGridCell<double>(columnName: 'dinDog', value: trialExamAverage.dinDog),
        DataGridCell<double>(columnName: 'dinYan', value: trialExamAverage.dinYan),
        DataGridCell<double>(columnName: 'dinNet', value: trialExamAverage.dinNet),
        DataGridCell<double>(columnName: 'topDog', value: trialExamAverage.topDog),
        DataGridCell<double>(columnName: 'topYan', value: trialExamAverage.topYan),
        DataGridCell<double>(columnName: 'topNet', value: trialExamAverage.topNet),
      ],
    );

     */
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Container(
        decoration: tableBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<TrialExamResultCubit>().showTrialExamStatics();
                },
                child: const Text('Detaylı İstatistikler')),
            _getTrialExamDataGrid(widget.trialExamResultList),
            _buildDataPager(),
          ],
        ),
      ),
    );
  }
}

class TrialExamResultDataSource extends DataGridSource {
  TrialExamResultDataSource({required List<TrialExamResult> trialExamResultList}) {
    _trialExamResultList = trialExamResultList;
    // _tiralExamResultDataGridRowList.clear();
    // _tiralExamResultDataGridRowList.add(_getFooter());
    _tiralExamResultDataGridRowList = trialExamResultList
        .map((e) => DataGridRow(
              cells: [
                DataGridCell<String>(columnName: 'student_no', value: e.studentNumber),
                DataGridCell<String>(columnName: 'student_name', value: e.studentName),
                DataGridCell<String>(columnName: 'student_class', value: e.className),
                DataGridCell<int>(columnName: 'turDog', value: e.turDog),
                DataGridCell<int>(columnName: 'turYan', value: e.turYan),
                DataGridCell<String>(columnName: 'turNet', value: _getNumberFormat(e.turNet)),
                DataGridCell<int>(columnName: 'matDog', value: e.matDog),
                DataGridCell<int>(columnName: 'matYan', value: e.matYan),
                DataGridCell<String>(columnName: 'matNet', value: _getNumberFormat(e.matNet)),
                DataGridCell<int>(columnName: 'fenDog', value: e.fenDog),
                DataGridCell<int>(columnName: 'fenYan', value: e.fenYan),
                DataGridCell<String>(columnName: 'fenNet', value: _getNumberFormat(e.fenNet)),
                DataGridCell<int>(columnName: 'sosDog', value: e.sosDog),
                DataGridCell<int>(columnName: 'sosYan', value: e.sosYan),
                DataGridCell<String>(columnName: 'sosNet', value: _getNumberFormat(e.sosNet)),
                DataGridCell<int>(columnName: 'ingDog', value: e.ingDog),
                DataGridCell<int>(columnName: 'ingYan', value: e.ingYan),
                DataGridCell<String>(columnName: 'ingNet', value: _getNumberFormat(e.ingNet)),
                DataGridCell<int>(columnName: 'dinDog', value: e.dinDog),
                DataGridCell<int>(columnName: 'dinYan', value: e.dinYan),
                DataGridCell<String>(columnName: 'dinNet', value: _getNumberFormat(e.dinNet)),
                DataGridCell<int>(columnName: 'topDog', value: _getTopDog(e)),
                DataGridCell<int>(columnName: 'topYan', value: _getTopYan(e)),
                DataGridCell<String>(columnName: 'topNet', value: _getNumberFormat(_getTopNet(e))),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _tiralExamResultDataGridRowList = [];
  List<TrialExamResult> _trialExamResultList = [];

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: AutoSizeText(
          e.value == null ? '  ' : e.value.toString(),
          style: _getNetTextStyle(e),
        ),
      );
    }).toList());
  }

  @override
  List<DataGridRow> get rows => _tiralExamResultDataGridRowList;

  String _getNumberFormat(double? net) {
    if (net != null) {
      final format = NumberFormat('#.00').format(net);
      return format;
    } else {
      return "0";
    }
  }

  TextStyle _getNetTextStyle(DataGridCell e) {
    if (e.columnName == 'student_name' || e.columnName == 'student_no' || e.columnName == 'student_class') {
      return const TextStyle(
        fontSize: 12,
        color: Colors.amber,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      if (e.columnName == 'turNet' ||
          e.columnName == 'matNet' ||
          e.columnName == 'fenNet' ||
          e.columnName == 'ingNet' ||
          e.columnName == 'sosNet' ||
          e.columnName == 'dinNet') {
        return const TextStyle(
          fontSize: 12,
          color: Colors.amber,
          overflow: TextOverflow.ellipsis,
        );
      } else {
        return const TextStyle(
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
        );
      }
    }
  }

  DataGridRow _getFooter() {
    final trialExamAverage = _getAverage();
    return DataGridRow(
      cells: [
        DataGridCell<String>(columnName: 'student_no', value: ''),
        DataGridCell<String>(columnName: 'student_name', value: 'Ortalama'),
        DataGridCell<String>(columnName: 'student_class', value: ''),
        DataGridCell<double>(columnName: 'turDog', value: trialExamAverage.turDog),
        DataGridCell<double>(columnName: 'turYan', value: trialExamAverage.turYan),
        DataGridCell<double>(columnName: 'turNet', value: trialExamAverage.turNet),
        DataGridCell<double>(columnName: 'matDog', value: trialExamAverage.matDog),
        DataGridCell<double>(columnName: 'matYan', value: trialExamAverage.matYan),
        DataGridCell<double>(columnName: 'matNet', value: trialExamAverage.matNet),
        DataGridCell<double>(columnName: 'fenDog', value: trialExamAverage.fenDog),
        DataGridCell<double>(columnName: 'fenYan', value: trialExamAverage.fenYan),
        DataGridCell<double>(columnName: 'fenNet', value: trialExamAverage.fenNet),
        DataGridCell<double>(columnName: 'sosDog', value: trialExamAverage.sosDog),
        DataGridCell<double>(columnName: 'sosYan', value: trialExamAverage.sosYan),
        DataGridCell<double>(columnName: 'sosNet', value: trialExamAverage.sosNet),
        DataGridCell<double>(columnName: 'ingDog', value: trialExamAverage.ingDog),
        DataGridCell<double>(columnName: 'ingYan', value: trialExamAverage.ingYan),
        DataGridCell<double>(columnName: 'ingNet', value: trialExamAverage.ingNet),
        DataGridCell<double>(columnName: 'dinDog', value: trialExamAverage.dinDog),
        DataGridCell<double>(columnName: 'dinYan', value: trialExamAverage.dinYan),
        DataGridCell<double>(columnName: 'dinNet', value: trialExamAverage.dinNet),
        DataGridCell<double>(columnName: 'topDog', value: trialExamAverage.topDog),
        DataGridCell<double>(columnName: 'topYan', value: trialExamAverage.topYan),
        DataGridCell<double>(columnName: 'topNet', value: trialExamAverage.topNet),
      ],
    );
  }

  int _getTopDog(TrialExamResult e) {
    return e.turDog! + e.matDog! + e.fenDog! + e.sosDog! + e.ingDog! + e.dinDog!;
  }

  int _getTopYan(TrialExamResult e) {
    return e.turYan! + e.matYan! + e.fenYan! + e.sosYan! + e.ingYan! + e.dinYan!;
  }

  double _getTopNet(TrialExamResult e) {
    return e.turNet! + e.matNet! + e.fenNet! + e.sosNet! + e.ingNet! + e.dinNet!;
  }

  TrialExamAverage _getAverage() {
    double turDog = 0;
    double turYan = 0;
    double turNet = 0;
    double matDog = 0;
    double matYan = 0;
    double matNet = 0;
    double fenDog = 0;
    double fenYan = 0;
    double fenNet = 0;
    double sosDog = 0;
    double sosYan = 0;
    double sosNet = 0;
    double ingDog = 0;
    double ingYan = 0;
    double ingNet = 0;
    double dinDog = 0;
    double dinYan = 0;
    double dinNet = 0;

    var i = 0;

    for (var trialExam in _trialExamResultList) {
      turDog = turDog + trialExam.turDog!;
      turYan = turYan + trialExam.turYan!;
      turNet = turNet + trialExam.turNet!;
      matDog = matDog + trialExam.matDog!;
      matYan = matYan + trialExam.matYan!;
      matNet = matNet + trialExam.matNet!;
      fenDog = fenDog + trialExam.fenDog!;
      fenYan = fenYan + trialExam.fenYan!;
      fenNet = fenNet + trialExam.fenNet!;
      sosDog = sosDog + trialExam.sosDog!;
      sosYan = sosYan + trialExam.sosYan!;
      sosNet = sosNet + trialExam.sosNet!;
      dinDog = dinDog + trialExam.dinDog!;
      dinYan = dinYan + trialExam.dinYan!;
      dinNet = dinNet + trialExam.dinNet!;
      ingDog = ingDog + trialExam.ingDog!;
      ingYan = ingYan + trialExam.ingYan!;
      ingNet = ingNet + trialExam.ingNet!;
      i++;
    }

    var examAverage = TrialExamAverage(
      turDog: turDog / i,
      turYan: turYan / i,
      turNet: turNet / i,
      matDog: matDog / i,
      matYan: matYan / i,
      matNet: matNet / i,
      fenDog: fenDog / i,
      fenYan: fenYan / i,
      fenNet: fenNet / i,
      sosDog: sosDog / i,
      sosYan: sosYan / i,
      sosNet: sosNet / i,
      ingDog: ingDog / i,
      ingYan: ingYan / i,
      ingNet: ingNet / i,
      dinDog: dinDog / i,
      dinYan: dinYan / i,
      dinNet: dinNet / i,
      topDog: (turDog + matDog + fenDog + sosDog + ingDog + dinDog) / i,
      topYan: (turYan + matYan + fenYan + sosYan + ingYan + dinYan) / i,
      topNet: (turNet + matNet + fenNet + sosNet + ingNet + dinNet) / i,
    );

    return examAverage;
  }
}
