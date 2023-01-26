import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';

import '../../../../common/constants.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../core/widgets/containers/app_list_box_container.dart';
import '../../../../core/widgets/text/app_box_title.dart';
import '../cubit/student_trial_exam_detail_cubit.dart';

import 'student_trial_exam_detail_card/student_trial_exam_detail_card.dart';

class StudentTrialExamDetailContainerView extends StatelessWidget {
  const StudentTrialExamDetailContainerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(
      child: Column(
        children: [
          const AppBoxTitle(isBack: false, title: 'Deneme Sınavları Öğrenci Sonuç Karnesi'),
          BlocBuilder<StudentTrialExamDetailCubit, StudentTrialExamDetailState>(
            builder: (context, state) {
              if (state is StudentTrialExamStudentSelectedStade) {
                final studentTrialExamResultList = state.studentTrialExamResultList;
                final student = state.student;
                final trialExamStudentResult = state.trialExamStudentResult;
                final studentTrialExamGraphList = state.studentTrialExamGraphList;
                final totalNetGraph = state.totalNetGraph;
                final classAverages = state.classAverages;
                final schoolAverages = state.schoolAverages;

                if (studentTrialExamResultList != null &&
                    studentTrialExamResultList.isNotEmpty &&
                    trialExamStudentResult != null &&
                    studentTrialExamGraphList != null &&
                    schoolAverages != null &&
                    classAverages != null &&
                    totalNetGraph != null) {
                  return Column(
                    children: [
                      StudentTrialExamDetailCard(
                        student: student,
                        studentTrialExamResultList: studentTrialExamResultList,
                        trialExamStudentResult: trialExamStudentResult,
                        studentTrialExamGraphList: studentTrialExamGraphList,
                        totalNetGraph: totalNetGraph,
                        classAverages: classAverages,
                        schoolAverages: schoolAverages,
                      ),
                    ],
                  );

                  //return MyPieChart();
                } else {
                  return SizedBox(
                      height: minimumBoxHeight,
                      child: Center(
                          child: Text(
                        'Öğrencinin deneme sınavı sonucu bulunamadı!',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )));
                }
              } else {
                return const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress());
              }
            },
          )
        ],
      ),
    );
  }
}

class MyPieChart extends StatelessWidget {
  const MyPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentClassList = context.read<ClassListCubit>().studentWithClassList;
    final studenList = studentClassList![14].studentList!;

    const katsayi = 0.00979;

    return SizedBox(
      height: 500,
      child: PieChart(
        PieChartData(
          sectionsSpace: 1,
          centerSpaceRadius: 0,
          sections: [
            for (int i = 0; i < studenList.length; i++)
              PieChartSectionData(
                value: 1,
                radius: 250,
                showTitle: false,
                badgePositionPercentageOffset: .7,
                badgeWidget: Transform.rotate(
                  angle: ((i + 1) * (studenList.length * katsayi)),
                  child: Text(studenList[i].studentName!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
