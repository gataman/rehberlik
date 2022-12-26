library admin_trial_exam_view;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/views/admin/admin_base/admin_base_view.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_total/trial_exam_total_container.dart';

import 'cubit/trial_exam_total_cubit.dart';

class AdminTrialExamTotalView extends AdminBaseView {
  const AdminTrialExamTotalView({required this.classLevel, Key? key}) : super(key: key);
  final int classLevel;

  @override
  Widget get firstView => const TrialExamTotalContainer();

  @override
  Widget get secondView => const Text('Sag');

  @override
  bool get isBack => true;

  @override
  bool get isFullPage => true;

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<TrialExamTotalCubit>(
        create: (_) => TrialExamTotalCubit()..fetchTrialExamStudentResultList(classLevel: classLevel),
        lazy: false,
      ),
    ];

    return providers;
  }
}
