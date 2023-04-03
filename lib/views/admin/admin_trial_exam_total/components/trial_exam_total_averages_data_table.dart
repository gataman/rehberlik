import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/data_table/sf_data_grid_icon.dart';
import '../../../../models/trial_exam_student_result.dart';
import '../cubit/trial_exam_total_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:rehberlik/common/helper/save_file_mobile.dart'
    if (dart.library.html) 'package:rehberlik/common/helper/save_file_web.dart';
import '../../../../common/constants.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../core/widgets/containers/app_list_box_container.dart';
import '../../../../core/widgets/text/app_box_title.dart';
import '../../../../responsive.dart';

class TrialExamTotalAveragesDataTable extends StatefulWidget {
  const TrialExamTotalAveragesDataTable({Key? key, required this.trialExamStudentResultList}) : super(key: key);
  final List<TrialExamStudentResult> trialExamStudentResultList;

  @override
  State<TrialExamTotalAveragesDataTable> createState() => _TrialExamTotalAveragesDataTableState();
}

class _TrialExamTotalAveragesDataTableState extends State<TrialExamTotalAveragesDataTable> {
  final String _dogruLabel = "Doğ";
  final String _netLabel = "Net";
  final String _pointLabel = "Puan";
  final String _schoolRankLabel = "Okul";
  final String _classRankLabel = "Sınıf";
  final String _yanlisLabel = "Yan";
  // = 25;

  late _TrialExamResultDataSource _trialExamResultDataSource;
  late List<TrialExamStudentResult> _trialExamStudentResultList;
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    _trialExamStudentResultList = widget.trialExamStudentResultList;
    _trialExamResultDataSource = _TrialExamResultDataSource(trialExamResultList: _trialExamStudentResultList);

    /// Programmaticaly sorting based on string length for 'customer name' GirdColumn
    _sortColumns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(
        child: Column(
      children: [
        const AppBoxTitle(isBack: true, title: 'Deneme Sonuçları Ortalamaları'),
        const Divider(
          thickness: 1,
          height: .5,
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                future: _getTrialExamDataGrid(_trialExamStudentResultList),
                builder: (context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.hasData) {
                    return Card(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          snapshot.data!, // DatGridWİdget
                          // _buildDataPager(),
                          Row(
                            children: [
                              _detailButton(context),
                              const SizedBox(
                                width: 4,
                              ),
                              _exportButton(context),
                            ],
                          )
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
        ),
      ],
    ));
  }

  Future<Widget> _getTrialExamDataGrid(List<TrialExamStudentResult> trialExamResultList) async {
    //subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    await Future.delayed(const Duration(seconds: 1));

    var columnWidth = double.nan;
    if (context.mounted) {
      columnWidth = 35;
    }

    return SizedBox(
        height: 450,
        child: SfDataGridIcon(
          dataGridSource: _trialExamResultDataSource,
          child: SfDataGrid(
            key: key,
            allowMultiColumnSorting: true,
            allowSorting: true,
            //allowFiltering: true,
            columnWidthMode: _getWidthMode(),
            allowTriStateSorting: true,
            allowFiltering: true,
            frozenColumnsCount: 2,
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            headerRowHeight: 30,
            defaultColumnWidth: columnWidth,
            rowHeight: 40,
            //rowsPerPage: _rowsPerPage,
            //footerFrozenRowsCount: 1,
            //footer: _getFooter(),
            stackedHeaderRows: _getStackedHeaderRows(),
            source: _trialExamResultDataSource,
            columns: _getColumns(),
          ),
        ));
  }

  ElevatedButton _detailButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        //exportDataGridToExcel();
        context.read<TrialExamTotalCubit>().showGraphState();
        //context.read<TrialExamResultCubit>().calculateAllStudentRanks(6);
      },
      style: ElevatedButton.styleFrom(
        shape: const BeveledRectangleBorder(),
      ),
      child: Text(
        'Sınıf İstatistikleri',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  ElevatedButton _exportButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        exportDataGridToExcel();
      },
      icon: const Icon(Icons.download_outlined),
      style: ElevatedButton.styleFrom(
        shape: const BeveledRectangleBorder(),
      ),
      label: Text(
        'Excel indir',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  Future<void> exportDataGridToExcel() async {
    if (key.currentState != null) {
      final xlsio.Workbook workbook = key.currentState!.exportToExcelWorkbook();
      final List<int> bytes = workbook.saveAsStream();
      //debugPrint(bytes.toString());
      FileSaveHelper.saveAndLaunchFile(bytes, 'deneme.xlsx');
      workbook.dispose();
    }
  }

  List<StackedHeaderRow> _getStackedHeaderRows() {
    List<StackedHeaderRow> stackedHeaderRows;
    stackedHeaderRows = <StackedHeaderRow>[
      StackedHeaderRow(cells: <StackedHeaderCell>[
        StackedHeaderCell(columnNames: <String>[
          'okulS',
          'Adı Soyadı',
          'No',
          'Sınıfı',
        ], child: _getWidgetForStackedHeaderCell('')),
        StackedHeaderCell(columnNames: <String>[
          'turDog',
          'turYan',
          'turNet',
        ], child: _getWidgetForStackedHeaderCell('Türkçe'), text: 'Türkçe'),
        StackedHeaderCell(columnNames: <String>[
          'matDog',
          'matYan',
          'matNet',
        ], child: _getWidgetForStackedHeaderCell('Matematik'), text: 'Matematik'),
        StackedHeaderCell(columnNames: <String>[
          'fenDog',
          'fenYan',
          'fenNet',
        ], child: _getWidgetForStackedHeaderCell('Fen'), text: 'Fen'),
        StackedHeaderCell(columnNames: <String>[
          'sosDog',
          'sosYan',
          'sosNet',
        ], child: _getWidgetForStackedHeaderCell('Sosyal'), text: 'Sosyal'),
        StackedHeaderCell(columnNames: <String>[
          'ingDog',
          'ingYan',
          'ingNet',
        ], child: _getWidgetForStackedHeaderCell('İngilizce'), text: 'İngilizce'),
        StackedHeaderCell(columnNames: <String>[
          'dinDog',
          'dinYan',
          'dinNet',
        ], child: _getWidgetForStackedHeaderCell('Din'), text: 'Din'),
        StackedHeaderCell(columnNames: <String>[
          'totDog',
          'totYan',
          'totNet',
          'sınıfS',
          'puan',
        ], child: _getWidgetForStackedHeaderCell('Toplam'), text: 'Toplam'),
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
      GridColumn(columnName: 'okulS', label: _getLabelTitleText(_schoolRankLabel), allowFiltering: false),
      GridColumn(
        width: Responsive.isMobile(context) ? 100 : 150,
        columnName: 'Adı Soyadı',
        label: _getLabelTitleText("Öğrenci Adı"),
      ),
      GridColumn(columnName: 'No', label: _getLabelTitleText("No"), allowFiltering: false),
      GridColumn(
        columnName: 'Sınıfı',
        label: _getLabelTitleText("Sınıfı"),
      ),
      GridColumn(columnName: 'turDog', allowFiltering: false, label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'turYan', allowFiltering: false, label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'turNet', allowFiltering: false, label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'matDog', allowFiltering: false, label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'matYan', allowFiltering: false, label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'matNet', allowFiltering: false, label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'fenDog', allowFiltering: false, label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'fenYan', allowFiltering: false, label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'fenNet', allowFiltering: false, label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'sosDog', allowFiltering: false, label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'sosYan', allowFiltering: false, label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'sosNet', allowFiltering: false, label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'ingDog', allowFiltering: false, label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'ingYan', allowFiltering: false, label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'ingNet', allowFiltering: false, label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'dinDog', allowFiltering: false, label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'dinYan', allowFiltering: false, label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'dinNet', allowFiltering: false, label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'totDog', allowFiltering: false, label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'totYan', allowFiltering: false, label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'totNet', allowFiltering: false, label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'sınıfS', allowFiltering: false, label: _getLabelTitleText(_classRankLabel)),
      GridColumn(columnName: 'puan', allowFiltering: false, label: _getLabelTitleText(_pointLabel), width: 60),
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

  /* Widget _buildDataPager() {
    var pageCount = _trialExamStudentResultList.length / _rowsPerPage;
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
  } */

  void _sortColumns() {
    _trialExamResultDataSource.sortedColumns
        .add(const SortColumnDetails(name: 'puan', sortDirection: DataGridSortDirection.descending));
    _trialExamResultDataSource.sort();
  }

  ColumnWidthMode _getWidthMode() => Responsive.isMobile(context) ? ColumnWidthMode.none : ColumnWidthMode.fill;
}

class _TrialExamResultDataSource extends DataGridSource {
  _TrialExamResultDataSource({required List<TrialExamStudentResult> trialExamResultList}) {
    _tiralExamResultDataGridRowList = trialExamResultList
        .map((e) => DataGridRow(
              cells: [
                DataGridCell<int>(columnName: 'okulS', value: e.schoolRank),
                DataGridCell<String>(columnName: 'Adı Soyadı', value: e.studentName),
                DataGridCell<String>(columnName: 'No', value: e.studentNumber),
                DataGridCell<String>(columnName: 'Sınıfı', value: e.className),
                DataGridCell<double>(columnName: 'turDog', value: _getNumberFormat(e.turDogAvg)),
                DataGridCell<double>(columnName: 'turYan', value: _getNumberFormat(e.turYanAvg)),
                DataGridCell<double>(columnName: 'turNet', value: _getNumberFormat(e.turNetAvg)),
                DataGridCell<double>(columnName: 'matDog', value: _getNumberFormat(e.matDogAvg)),
                DataGridCell<double>(columnName: 'matYan', value: _getNumberFormat(e.matYanAvg)),
                DataGridCell<double>(columnName: 'matNet', value: _getNumberFormat(e.matNetAvg)),
                DataGridCell<double>(columnName: 'fenDog', value: _getNumberFormat(e.fenDogAvg)),
                DataGridCell<double>(columnName: 'fenYan', value: _getNumberFormat(e.fenYanAvg)),
                DataGridCell<double>(columnName: 'fenNet', value: _getNumberFormat(e.fenNetAvg)),
                DataGridCell<double>(columnName: 'sosDog', value: _getNumberFormat(e.sosDogAvg)),
                DataGridCell<double>(columnName: 'sosYan', value: _getNumberFormat(e.sosYanAvg)),
                DataGridCell<double>(columnName: 'sosNet', value: _getNumberFormat(e.sosNetAvg)),
                DataGridCell<double>(columnName: 'ingDog', value: _getNumberFormat(e.ingDogAvg)),
                DataGridCell<double>(columnName: 'ingYan', value: _getNumberFormat(e.ingYanAvg)),
                DataGridCell<double>(columnName: 'ingNet', value: _getNumberFormat(e.ingNetAvg)),
                DataGridCell<double>(columnName: 'dinDog', value: _getNumberFormat(e.dinDogAvg)),
                DataGridCell<double>(columnName: 'dinYan', value: _getNumberFormat(e.dinYanAvg)),
                DataGridCell<double>(columnName: 'dinNet', value: _getNumberFormat(e.dinNetAvg)),
                DataGridCell<double>(columnName: 'totDog', value: _getNumberFormat(e.totDogAvg)),
                DataGridCell<double>(columnName: 'totYan', value: _getNumberFormat(e.totYanAvg)),
                DataGridCell<double>(columnName: 'totNet', value: _getNumberFormat(e.totNetAvg)),
                DataGridCell<int>(columnName: 'sınıfS', value: e.classRank),
                DataGridCell<double>(columnName: 'puan', value: e.totalPointAvg),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _tiralExamResultDataGridRowList = [];

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        padding:
            e.columnName == 'puan' || e.columnName == 'Adı Soyadı' ? const EdgeInsets.only(left: 3) : EdgeInsets.zero,
        alignment: e.columnName == 'puan' || e.columnName == 'Adı Soyadı' ? Alignment.centerLeft : Alignment.center,
        child: AutoSizeText(
          e.value == null ? '  ' : e.value.toString(),
          style: _getNetTextStyle(e),
          textAlign: e.columnName == 'puan' || e.columnName == 'Adı Soyadı' ? TextAlign.start : TextAlign.center,
        ),
      );
    }).toList());
  }

  @override
  List<DataGridRow> get rows => _tiralExamResultDataGridRowList;

  double _getNumberFormat(double? net) {
    if (net != null) {
      final format = NumberFormat('#.00', 'en_US').format(net);
      return double.parse(format);
    } else {
      return 0;
    }
  }

  TextStyle _getNetTextStyle(DataGridCell e) {
    if (e.columnName == 'Adı Soyadı' || e.columnName == 'No' || e.columnName == 'Sınıfı') {
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
          e.columnName == 'dinNet' ||
          e.columnName == 'puan') {
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

/*
  int _getTopDog(TrialExamStudentResult e) {
    return e.turDogAvg! + e.matDog! + e.fenDog! + e.sosDog! + e.ingDog! + e.dinDog!;
  }

  int _getTopYan(TrialExamResult e) {
    return e.turYan! + e.matYan! + e.fenYan! + e.sosYan! + e.ingYan! + e.dinYan!;
  }

  double _getTopNet(TrialExamResult e) {
    return e.turNet! + e.matNet! + e.fenNet! + e.sosNet! + e.ingNet! + e.dinNet!;
  }
  */
}
