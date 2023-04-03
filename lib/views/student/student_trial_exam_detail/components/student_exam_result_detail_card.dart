import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../responsive.dart';

import '../../../../common/constants.dart';
import '../../../../models/trial_exam_class_result.dart';
import '../../../../models/trial_exam_result.dart';
import 'trial_exam_detail_helper.dart';

class StudentExamResultDetailCard extends StatefulWidget {
  const StudentExamResultDetailCard({
    Key? key,
    required this.trialExamResult,
    required this.trialExamClassResultList,
  }) : super(key: key);

  final TrialExamResult trialExamResult;
  final List<TrialExamClassResult>? trialExamClassResultList;

  @override
  State<StudentExamResultDetailCard> createState() => _StudentExamResultDetailCardState();
}

class _StudentExamResultDetailCardState extends State<StudentExamResultDetailCard> {
  late Map<String, dynamic> examResultMap;
  late TrialExamDetailHelper _helper;

  @override
  void initState() {
    _helper = TrialExamDetailHelper(
      studentExamResult: widget.trialExamResult,
      classesExamResultList: widget.trialExamClassResultList!,
    );

    examResultMap = _helper.getStudentExamResultMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalPoint = widget.trialExamResult.totalPoint?.toStringAsFixed(3);
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          _resultTable(context),
          const SizedBox(height: defaultPadding * 2),
          const Divider(thickness: 1, height: .5),
          const SizedBox(height: defaultPadding),
          _pointAndRankInfo(context, totalPoint),
        ],
      ),
    );
  }

  Row _pointAndRankInfo(BuildContext context, String? totalPoint) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _titleCard(context, 'Puanı', totalPoint ?? ''),
        const Spacer(flex: 5),
        _titleCard(context, 'Okul Sırası', widget.trialExamResult.schoolRank.toString()),
        const Spacer(flex: 5),
        _titleCard(context, 'Sınıf Sırası', widget.trialExamResult.classRank.toString()),
      ],
    );
  }

  Card _resultTable(BuildContext context) {
    return Card(
      shape: const BeveledRectangleBorder(),
      elevation: 2,
      child: Table(
        columnWidths: const {0: FlexColumnWidth(2)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Theme.of(context).dividerColor),
        children: [_tableTitles(context), ..._tableStudentData(context), _tableFooters(context)],
      ),
    );
  }

  Expanded _titleCard(BuildContext context, String title, String value) {
    return Expanded(
      flex: 30,
      child: SizedBox(
        child: Card(
          elevation: 4,
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2, vertical: defaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  title,
                  style: _cardTitleStyle(context),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(
                  thickness: 1,
                  height: .5,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                AutoSizeText(
                  value,
                  style: _cardValueStyle(context),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _cardTitleStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle _cardValueStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  //Tables:
  TableRow _tableTitles(BuildContext context) {
    return TableRow(children: [
      _tableLabelTitle(context, 'Dersler'),
      _tableTitleValue(context, 'Doğru'),
      _tableTitleValue(context, 'Yanlış'),
      _tableTitleValue(context, 'Boş'),
      _tableTitleValue(context, 'Net'),
      _tableTitleValue(context, 'Sınıf Ort.'),
      _tableTitleValue(context, 'Okul Ort.'),
    ]);
  }

  TableRow _tableFooters(BuildContext context) {
    final data = _helper.getTotalCount();
    return TableRow(children: [
      _tableLabelTitle(context, 'Toplam'),
      _tableTitleValue(context, data['dog'].toString()),
      _tableTitleValue(context, data['yan'].toString()),
      _tableTitleValue(context, data['bos'].toString()),
      _tableTitleValue(context, double.parse(data['net'].toString()).toStringAsFixed(2)),
      _tableTitleValue(context, double.parse(data['sinif'].toString()).toStringAsFixed(2)),
      _tableTitleValue(context, double.parse(data['okul'].toString()).toStringAsFixed(2)),
    ]);
  }

  Widget _tableLabelTitle(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(
          value,
          style: Responsive.isMobile(context)
              ? Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary)
              : Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _tableLabelValue(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(
          value,
          style: Responsive.isMobile(context)
              ? Theme.of(context).textTheme.labelSmall
              : Theme.of(context).textTheme.labelMedium,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _tableTitleValue(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            value,
            style: Responsive.isMobile(context)
                ? Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary)
                : Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Widget _tableValues(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            value,
            style: Responsive.isMobile(context)
                ? Theme.of(context).textTheme.bodySmall
                : Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );

  List<TableRow> _tableStudentData(BuildContext context) {
    final List<TableRow> tableRowList = [];

    examResultMap.forEach((key, data) {
      tableRowList.add(TableRow(children: [
        _tableLabelValue(context, key),
        _tableValues(context, data['dog'].toString()),
        _tableValues(context, data['yan'].toString()),
        _tableValues(context, data['bos'].toString()),
        _tableValues(context, double.parse(data['net'].toString()).toStringAsFixed(2)),
        _tableValues(context, double.parse(data['sinif'].toString()).toStringAsFixed(2)),
        _tableValues(context, double.parse(data['okul'].toString()).toStringAsFixed(2)),
      ]));
    });

    return tableRowList;
  }
}
