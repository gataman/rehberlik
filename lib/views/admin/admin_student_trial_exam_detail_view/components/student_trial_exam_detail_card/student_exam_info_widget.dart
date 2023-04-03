import 'package:flutter/material.dart';
import '../../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';

import '../../../../../common/constants.dart';
import '../../../../../core/widgets/charts/line_charts/trial_exam_student_line_chart2.dart';
import '../../../../../models/student.dart';
import '../../../../../models/trial_exam_student_result.dart';
import '../../../../../responsive.dart';

class StudentExamInfoWidget extends StatelessWidget {
  const StudentExamInfoWidget(
      {Key? key, required this.student, required this.trialExamStudentResult, required this.totalNetGraph})
      : super(key: key);
  final Student student;
  final TrialExamStudentResult trialExamStudentResult;
  final TrialExamGraph totalNetGraph;

  @override
  Widget build(BuildContext context) {
    return Card(elevation: 2, child: Responsive.isMobile(context) ? _mobileView(context) : _desktopView(context));
  }

  Widget _desktopView(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: _infoTable(context, false),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 370,
                child: TrialExamStudentLineChart2(
                  examGraph: totalNetGraph,
                  lessonIndex: 5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _mobileView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _infoTable(context, true),
        const SizedBox(
          height: defaultPadding,
        ),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 370,
              child: TrialExamStudentLineChart2(
                examGraph: totalNetGraph,
                lessonIndex: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Table _infoTable(BuildContext context, bool isMobile) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        _buildTableRow(
          context: context,
          labelName: 'Adı Soyadı',
          value: student.studentName ?? '',
          hasRightDivider: !isMobile,
        ),
        _buildTableRow(
          context: context,
          labelName: 'Sınıfı',
          value: student.className ?? '',
          hasRightDivider: !isMobile,
        ),
        _buildTableRow(
          context: context,
          labelName: 'Numarası',
          value: student.studentNumber ?? '',
          hasRightDivider: !isMobile,
        ),
        _buildTableRow(
          context: context,
          labelName: 'Sınıf Sırası',
          value: trialExamStudentResult.classRank.toString(),
          hasRightDivider: !isMobile,
        ),
        _buildTableRow(
          context: context,
          labelName: 'Okul Sırası',
          value: trialExamStudentResult.schoolRank.toString(),
          hasBottomDivider: isMobile,
          hasRightDivider: !isMobile,
        ),
      ],
    );
  }

  TableRow _buildTableRow({
    required BuildContext context,
    required String labelName,
    required String value,
    bool hasBottomDivider = true,
    bool hasRightDivider = true,
  }) {
    return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(labelName, style: Theme.of(context).textTheme.labelLarge),
          ),
          SizedBox(
            width: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(':', style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
        decoration: BoxDecoration(
          border: Border(
            bottom: hasBottomDivider ? BorderSide(color: Theme.of(context).dividerColor) : BorderSide.none,
            right: hasRightDivider ? BorderSide(color: Theme.of(context).dividerColor) : BorderSide.none,
          ),
        ));
  }
}
