import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/trial_exam.dart';
import '../admin_base/admin_base_view.dart';
import 'cubit/trial_exam_result_cubit.dart';

import 'components/trial_exam_result_container_view.dart';
import 'components/trial_exam_result_menu.dart';

class AdminTrialExamResultView extends AdminBaseView {
  final TrialExam trialExam;

  const AdminTrialExamResultView({required this.trialExam, Key? key}) : super(key: key);

  @override
  Widget get firstView => TrialExamResultContainerView();

  @override
  Widget get secondView => const TrialExamResultUploads();

  @override
  bool get isBack => true;

  @override
  bool get isFullPage => true;

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<TrialExamResultCubit>(
        create: (_) => TrialExamResultCubit()..fetchTrialExamResult(exam: trialExam),
        lazy: false,
      ),
    ];

    return providers;
  }
}
