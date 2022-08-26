part of admin_trial_exam_result_view;

class TrialExamResultDataGrid extends GetView<AdminTrialExamResultController> {
  TrialExamResultDataGrid({Key? key}) : super(key: key);
  final TrialExamResultDataSource _trialExamResultDataSource =
      TrialExamResultDataSource();

  final String _dogruLabel = "Doğ";

  final String _yanlisLabel = "Yan";

  final String _netLabel = "Net";

  @override
  Widget build(BuildContext context) {
    //_getTrialExamResultList();
    final trialExam = controller.selectedTrialExam;
    return Obx(() {
      final trialExamResultList = controller.trialExamResultList.value;
      debugPrint("Obx çalıştı Liste ${trialExamResultList.toString()}");

      if (trialExamResultList.isNotEmpty) {
        _trialExamResultDataSource.updateList(
            trialExamResultList: trialExamResultList);
      }

      return Container(
        decoration: defaultBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (trialExamResultList == null)
                const SizedBox(height: 250, child: DefaultCircularProgress()),
              if (trialExamResultList != null)
                GestureDetector(
                  onTap: () {
                    Get.back(id: 1);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${trialExam?.examName.toString()} ${trialExam?.classLevel.toString()} . Sınıf Deneme Sonucu",
                          style: defaultTitleStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              if (trialExamResultList != null && trialExamResultList.isNotEmpty)
                _getTrialExamDataGrid(trialExamResultList),
              if (trialExamResultList != null && trialExamResultList.isEmpty)
                const SizedBox(
                  height: 250,
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Text("Sınav sonuçları henüz girilmemiş!"),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _getTrialExamDataGrid(List<TrialExamResult> trialExamResultList) {
    //subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    return SfDataGrid(
      shrinkWrapRows: true,
      verticalScrollPhysics: const NeverScrollableScrollPhysics(),
      frozenColumnsCount: 3,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      headerRowHeight: 30,
      defaultColumnWidth: 35,
      rowHeight: 40,
      stackedHeaderRows: _getStackedHeaderRows(),
      source: _trialExamResultDataSource,
      columns: _getColumns(),
    );
  }

  List<StackedHeaderRow> _getStackedHeaderRows() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(columnNames: <String>[
          'student_no',
          'student_name',
          'student_class'
        ], child: _getWidgetForStackedHeaderCell('')),
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
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.amber),
        ));
  }

  List<GridColumn> _getColumns() {
    return <GridColumn>[
      GridColumn(
        columnName: 'student_no',
        label: _getLabelTitleText("No"),
      ),
      GridColumn(
        width: 100,
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
    controller.getAllTrialExamDetail();
  }
}

class TrialExamResultDataSource extends DataGridSource {
  List<DataGridRow> _tiralExamResultDataGridRowList = [];

  @override
  List<DataGridRow> get rows => _tiralExamResultDataGridRowList;

  void updateList({required List<TrialExamResult> trialExamResultList}) {
    if (trialExamResultList.isNotEmpty) {
      _tiralExamResultDataGridRowList = trialExamResultList
          .map(
            (e) => DataGridRow(
              cells: [
                DataGridCell<String>(
                    columnName: 'student_no', value: e.studentNumber),
                DataGridCell<String>(
                    columnName: 'student_name', value: e.studentName),
                DataGridCell<String>(
                    columnName: 'student_class', value: e.className),
                DataGridCell<int>(columnName: 'turDog', value: e.turDog),
                DataGridCell<int>(columnName: 'turYan', value: e.turYan),
                DataGridCell<double>(columnName: 'turNet', value: e.turNet),
                DataGridCell<int>(columnName: 'matDog', value: e.matDog),
                DataGridCell<int>(columnName: 'matYan', value: e.matYan),
                DataGridCell<double>(columnName: 'matNet', value: e.matNet),
                DataGridCell<int>(columnName: 'fenDog', value: e.fenDog),
                DataGridCell<int>(columnName: 'fenYan', value: e.fenYan),
                DataGridCell<double>(columnName: 'fenNet', value: e.fenNet),
                DataGridCell<int>(columnName: 'sosDog', value: e.sosDog),
                DataGridCell<int>(columnName: 'sosYan', value: e.sosYan),
                DataGridCell<double>(columnName: 'sosNet', value: e.sosNet),
                DataGridCell<int>(columnName: 'ingDog', value: e.ingDog),
                DataGridCell<int>(columnName: 'ingYan', value: e.ingYan),
                DataGridCell<double>(columnName: 'ingNet', value: e.ingNet),
                DataGridCell<int>(columnName: 'dinDog', value: e.dinDog),
                DataGridCell<int>(columnName: 'dinYan', value: e.dinYan),
                DataGridCell<double>(columnName: 'dinNet', value: e.dinNet),
              ],
            ),
          )
          .toList();
    }
    notifyListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          e.value == null ? '  ' : e.value.toString(),
          style: TextStyle(
              fontSize: 14,
              color: (e.columnName == 'student_name' ||
                      e.columnName == 'student_no' ||
                      e.columnName == 'student_class')
                  ? Colors.amber
                  : (e.columnName == 'turNet' || e.columnName == 'matNet')
                      ? Colors.teal
                      : Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }
}
