import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/views/admin/admin_student_trial_exam_detail_view.dart/components/student_trial_exam_detail_card/student_trial_exam_detail_card.dart';

import '../../../../common/constants.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../core/widgets/containers/app_list_box_container.dart';
import '../../../../core/widgets/text/app_box_title.dart';
import '../cubit/student_trial_exam_detail_cubit.dart';

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
                  return StudentTrialExamDetailCard(
                    student: student,
                    studentTrialExamResultList: studentTrialExamResultList,
                    trialExamStudentResult: trialExamStudentResult,
                    studentTrialExamGraphList: studentTrialExamGraphList,
                    totalNetGraph: totalNetGraph,
                    classAverages: classAverages,
                    schoolAverages: schoolAverages,
                  );
                } else {
                  return Text('Öğrencinin deneme sınavı sonucu yok!');
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
