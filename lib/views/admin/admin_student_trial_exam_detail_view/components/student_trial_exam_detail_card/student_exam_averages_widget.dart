import 'package:flutter/material.dart';
import 'package:rehberlik/responsive.dart';

import '../../../../../models/helpers/trial_exam_average_helper.dart';
import '../../../../../models/trial_exam_student_result.dart';

class StudentExamAveragesWidget extends StatelessWidget {
  const StudentExamAveragesWidget(
      {Key? key, required this.trialExamStudentResult, required this.schoolAverages, required this.classAverages})
      : super(key: key);

  final TrialExamStudentResult trialExamStudentResult;
  final TrialExamAverageHelper schoolAverages;
  final TrialExamAverageHelper classAverages;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const BeveledRectangleBorder(),
      elevation: 2,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Theme.of(context).dividerColor),
        children: [_tableTitles(context), _studentAverages(context), _classAverages(context), _schoolAverages(context)],
      ),
    );
  }

  TableRow _tableTitles(BuildContext context) {
    return TableRow(children: [
      _tableTitleValue(context, 'Ortalama'),
      _tableTitleValue(context, 'Türkçe'),
      _tableTitleValue(context, 'Sosyal'),
      _tableTitleValue(context, 'Din'),
      _tableTitleValue(context, 'İngilizce'),
      _tableTitleValue(context, 'Matematik'),
      _tableTitleValue(context, 'Fen'),
    ]);
  }

  Widget _tableTitleValue(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  TableRow _studentAverages(BuildContext context) {
    return TableRow(children: [
      _tableLabelValues(context, 'Ortalama'),
      _tableStudentValues(
        context,
        trialExamStudentResult.turNetAvg.toString(),
        trialExamStudentResult.turNetAvg > schoolAverages.turAvg,
      ),
      _tableStudentValues(
        context,
        trialExamStudentResult.sosNetAvg.toString(),
        trialExamStudentResult.sosNetAvg > schoolAverages.sosAvg,
      ),
      _tableStudentValues(
        context,
        trialExamStudentResult.dinNetAvg.toString(),
        trialExamStudentResult.dinNetAvg > schoolAverages.dinAvg,
      ),
      _tableStudentValues(
        context,
        trialExamStudentResult.ingNetAvg.toString(),
        trialExamStudentResult.ingNetAvg > schoolAverages.ingAvg,
      ),
      _tableStudentValues(
        context,
        trialExamStudentResult.matNetAvg.toString(),
        trialExamStudentResult.matNetAvg > schoolAverages.matAvg,
      ),
      _tableStudentValues(
        context,
        trialExamStudentResult.fenNetAvg.toString(),
        trialExamStudentResult.fenNetAvg > schoolAverages.fenAvg,
      ),
    ]);
  }

  TableRow _classAverages(BuildContext context) {
    return TableRow(children: [
      _tableLabelValues(context, 'Sınıf Ort.'),
      _tableValues(context, classAverages.turAvg.toString()),
      _tableValues(context, classAverages.sosAvg.toString()),
      _tableValues(context, classAverages.dinAvg.toString()),
      _tableValues(context, classAverages.ingAvg.toString()),
      _tableValues(context, classAverages.matAvg.toString()),
      _tableValues(context, classAverages.fenAvg.toString()),
    ]);
  }

  TableRow _schoolAverages(BuildContext context) {
    return TableRow(children: [
      _tableLabelValues(context, 'Okul Ort.'),
      _tableValues(context, schoolAverages.turAvg.toString()),
      _tableValues(context, schoolAverages.sosAvg.toString()),
      _tableValues(context, schoolAverages.dinAvg.toString()),
      _tableValues(context, schoolAverages.ingAvg.toString()),
      _tableValues(context, schoolAverages.matAvg.toString()),
      _tableValues(context, schoolAverages.fenAvg.toString()),
    ]);
  }

  Widget _tableLabelValues(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            value,
            style: Theme.of(context).textTheme.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Widget _tableStudentValues(BuildContext context, String value, bool isGreen) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!Responsive.isMobile(context))
                const Expanded(
                  child: SizedBox(),
                ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    value,
                    style: !Responsive.isMobile(context)
                        ? Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: isGreen ? Colors.green : Colors.red, fontWeight: FontWeight.bold)
                        : Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: isGreen ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              if (!Responsive.isMobile(context))
                Icon(
                  isGreen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: isGreen ? Colors.green : Colors.red,
                )
            ],
          ),
        ),
      );

  Widget _tableValues(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
}
