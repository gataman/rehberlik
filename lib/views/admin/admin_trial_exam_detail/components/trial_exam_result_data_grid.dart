part of admin_trial_exam_result_view;

class TrialExamResultDataGrid extends StatefulWidget {
  final List<TrialExamResult> trialExamResultList;

  const TrialExamResultDataGrid({Key? key, required this.trialExamResultList}) : super(key: key);

  @override
  State<TrialExamResultDataGrid> createState() => _TrialExamResultDataGridState();
}

class _TrialExamResultDataGridState extends State<TrialExamResultDataGrid> {
  late TrialExamResultDataSource _trialExamResultDataSource;

  final String _dogruLabel = "Doğ";
  final String _yanlisLabel = "Yan";
  final String _netLabel = "Net";
  late List<TrialExamResult> _trialExamResultList;
  int _rowsPerPage = 15;

  @override
  void initState() {
    _trialExamResultList = widget.trialExamResultList;
    _trialExamResultDataSource = TrialExamResultDataSource(trialExamResultList: _trialExamResultList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Build çalıştı");
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Container(
        decoration: tableBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getTrialExamDataGrid(widget.trialExamResultList),
            _buildDataPager(),
          ],
        ),
      ),
    );
  }

  Widget _getTrialExamDataGrid(List<TrialExamResult> trialExamResultList) {
    //subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    return SizedBox(
      height: 450,
      child: SfDataGrid(
        columnWidthMode: _getWidthMode(),
        frozenColumnsCount: 3,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        headerRowHeight: 30,
        defaultColumnWidth: Responsive.isMobile(context) ? 35 : double.nan,
        rowHeight: 40,
        rowsPerPage: _rowsPerPage,
        //footerFrozenRowsCount: 1,
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

  ColumnWidthMode _getWidthMode() =>
      Responsive.isMobile(context) ? ColumnWidthMode.none : ColumnWidthMode.fill;

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

  void _getTrialExamResultList() {
    //controller.getAllTrialExamDetail();
  }
}

class TrialExamResultDataSource extends DataGridSource {
  List<DataGridRow> _tiralExamResultDataGridRowList = [];

  @override
  List<DataGridRow> get rows => _tiralExamResultDataGridRowList;

  TrialExamResultDataSource({required List<TrialExamResult> trialExamResultList}) {
    _tiralExamResultDataGridRowList = trialExamResultList
        .map(
          (e) => DataGridRow(
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
            ],
          ),
        )
        .toList();

    //_tiralExamResultDataGridRowList.add(_getFooter());
  }

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

  String _getNumberFormat(double? turNet) {
    if (turNet != null) {
      final format = NumberFormat('#.00').format(turNet);
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
    return const DataGridRow(
      cells: [
        DataGridCell<String>(columnName: 'student_no', value: ''),
        DataGridCell<String>(columnName: 'student_name', value: 'Ortalama'),
        DataGridCell<String>(columnName: 'student_class', value: ''),
        DataGridCell<int>(columnName: 'turDog', value: 1),
        DataGridCell<int>(columnName: 'turYan', value: 2),
        DataGridCell<String>(columnName: 'turNet', value: '3,2'),
        DataGridCell<int>(columnName: 'matDog', value: 3),
        DataGridCell<int>(columnName: 'matYan', value: 4),
        DataGridCell<String>(columnName: 'matNet', value: '3,2'),
        DataGridCell<int>(columnName: 'fenDog', value: 5),
        DataGridCell<int>(columnName: 'fenYan', value: 6),
        DataGridCell<String>(columnName: 'fenNet', value: '3,2'),
        DataGridCell<int>(columnName: 'sosDog', value: 7),
        DataGridCell<int>(columnName: 'sosYan', value: 7),
        DataGridCell<String>(columnName: 'sosNet', value: '3,2'),
        DataGridCell<int>(columnName: 'ingDog', value: 7),
        DataGridCell<int>(columnName: 'ingYan', value: 7),
        DataGridCell<String>(columnName: 'ingNet', value: '3,2'),
        DataGridCell<int>(columnName: 'dinDog', value: 7),
        DataGridCell<int>(columnName: 'dinYan', value: 7),
        DataGridCell<String>(columnName: 'dinNet', value: '3,2'),
      ],
    );
  }
}
