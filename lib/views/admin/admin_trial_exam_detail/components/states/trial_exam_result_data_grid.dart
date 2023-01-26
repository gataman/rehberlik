import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import '../../../../../common/helper/save_file_mobile.dart'
    if (dart.library.html) '../../../../../common/helper/save_file_web.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/widgets/default_circular_progress.dart';
import '../../../../../models/trial_exam_result.dart';
import '../../../../../responsive.dart';
import '../../cubit/trial_exam_result_cubit.dart';
import '../../init/trial_exam_result_data_source.dart';

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
  final String _schoolRankLabel = "Sıra";
  final String _classRankLabel = "Sınıf";
  final String _yanlisLabel = "Yan";
  int _rowsPerPage = 25;

  late TrialExamResultDataSource _trialExamResultDataSource;
  late List<TrialExamResult> _trialExamResultList;
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    _trialExamResultList = widget.trialExamResultList;
    _trialExamResultDataSource = TrialExamResultDataSource(trialExamResultList: _trialExamResultList);
    _sortColumns();

    /// Programmaticaly sorting based on string length for 'customer name' GirdColumn

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
    );
  }

  ElevatedButton _detailButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        //exportDataGridToExcel();
        context.read<TrialExamResultCubit>().showTrialExamStatics();
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

  Future<Widget> _getTrialExamDataGrid(List<TrialExamResult> trialExamResultList) async {
    //subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    await Future.delayed(const Duration(seconds: 1));

    return SizedBox(
      height: 450,
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
            sortIcon: _setIcon(),
            filterIcon: const Icon(
              Icons.search,
              size: 14,
            )),
        child: SfDataGrid(
          key: key,
          allowMultiColumnSorting: true,
          //verticalScrollPhysics: const NeverScrollableScrollPhysics(),
          //shrinkWrapRows: true,
          allowSorting: true,
          allowFiltering: true,
          columnWidthMode: _getWidthMode(),
          allowTriStateSorting: true,
          frozenColumnsCount: 2,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,

          onCellTap: (details) {
            // debugPrint(details.rowColumnIndex.rowIndex.toString());
          },

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
      ),
    );
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
          'topDog',
          'topYan',
          'topNet',
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
      GridColumn(columnName: 'topDog', allowFiltering: false, label: _getLabelTitleText(_dogruLabel)),
      GridColumn(columnName: 'topYan', allowFiltering: false, label: _getLabelTitleText(_yanlisLabel)),
      GridColumn(columnName: 'topNet', allowFiltering: false, label: _getLabelTitleText(_netLabel)),
      GridColumn(columnName: 'sınıfS', allowFiltering: false, label: _getLabelTitleText(_classRankLabel)),
      GridColumn(columnName: 'puan', allowFiltering: false, label: _getLabelTitleText(_pointLabel), width: 60),
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
        .add(const SortColumnDetails(name: 'puan', sortDirection: DataGridSortDirection.descending));
    _trialExamResultDataSource.sort();
  }

  Future<void> exportDataGridToExcel() async {
    final xlsio.Workbook workbook = key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    FileSaveHelper.saveAndLaunchFile(bytes, 'deneme.xlsx');
    workbook.dispose();
  }

  _setIcon() {
    return Builder(
      builder: (context) {
        Widget? icon;
        String columnName = '';
        context.visitAncestorElements((element) {
          if (element is GridHeaderCellElement) {
            columnName = element.column.columnName;
          }
          return true;
        });
        var column = _trialExamResultDataSource.sortedColumns.findOrNull((element) => element.name == columnName);
        if (column != null) {
          if (column.sortDirection == DataGridSortDirection.ascending) {
            icon = const Icon(Icons.arrow_circle_up_rounded, size: 16);
          } else if (column.sortDirection == DataGridSortDirection.descending) {
            icon = const Icon(Icons.arrow_circle_down_rounded, size: 16);
          }
        }
        return icon ??
            const Icon(
              Icons.sort_outlined,
              size: .1,
            );
      },
    );
  }
}
