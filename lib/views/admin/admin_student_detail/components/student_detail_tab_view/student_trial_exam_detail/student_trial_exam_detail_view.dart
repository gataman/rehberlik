import 'package:flutter/material.dart';

class StudentTrialExamDetailView extends StatelessWidget {
  const StudentTrialExamDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('deneme'),
    );
  }

/*
  Widget _getGraphWidgetList(List<TrialExamGraph> graphList) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: graphList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
            childAspectRatio: Responsive.isMobile(context) ? 2 : 1.5,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding + 8,
          ),
          itemBuilder: (context, index) {
            return TrialExamBarChart(
              trialExamGraph: graphList[index],
            );
          }),
    );
  }
  */
}
