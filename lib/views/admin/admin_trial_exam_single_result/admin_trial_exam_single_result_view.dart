import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/trial_exam_result.dart';
import '../admin_base/admin_base_view.dart';
import '../admin_student_trial_exam_detail_view/cubit/student_trial_exam_detail_cubit.dart';

class AdminTrialExamSingleResultView extends AdminBaseView {
  const AdminTrialExamSingleResultView({
    Key? key,
    required this.trialExamResult,
  }) : super(key: key);
  final TrialExamResult trialExamResult;

  @override
  Widget get firstView => _getExamResultContainer();

  @override
  Widget get secondView => const Text('right');

  @override
  bool get isFullPage => true;

  @override
  bool get isBack => true;

  // @override
  // List<BlocProvider<StateStreamableSource<Object?>>> get providers {
  //   final providers = <BlocProvider>[
  //     BlocProvider<StudentTrialExamDetailCubit>(
  //         create: (_) => StudentTrialExamDetailCubit()..selectStudent(student),
  //         lazy: false,
  //       ),
  //   ];

  //   return providers;
  // }

  /*
 BlocProvider<StudentTrialExamListCubit>(
          create: (_) => StudentTrialExamListCubit()..fetchTrialExamList(classLevel: student.classLevel!),
          lazy: false,
        ),

  */

  Widget _getExamResultContainer() {
    return BlocBuilder<StudentTrialExamDetailCubit, StudentTrialExamDetailState>(
      builder: (context, state) {
        if (state is StudentTrialExamStudentSelectedStade) {
          return Text(state.studentTrialExamResultList.toString());
        } else {
          return Text('test');
        }
      },
    );
  }
}
