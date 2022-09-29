import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/views/admin/admin_student_trial_exam_detail_view.dart/components/student_trial_exam_detail_container_view.dart';
import 'package:rehberlik/views/admin/admin_student_trial_exam_detail_view.dart/components/student_trial_exam_detail_menu.dart';
import 'package:rehberlik/views/admin/admin_student_trial_exam_detail_view.dart/cubit/student_trial_exam_detail_cubit.dart';

import '../admin_base/admin_base_view.dart';

class AdminStudentsTrialExamDetailView extends AdminBaseView {
  const AdminStudentsTrialExamDetailView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const StudentTrialExamDetailContainerView();

  @override
  Widget get secondView => const StudentTrialExamDetailMenu();

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<StudentTrialExamDetailCubit>(
        create: (_) => StudentTrialExamDetailCubit(),
      ),
    ];
    return providers;
  }
}
