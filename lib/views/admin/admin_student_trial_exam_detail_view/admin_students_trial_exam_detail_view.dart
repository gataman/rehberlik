import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/student.dart';
import '../admin_base/admin_base_view.dart';
import 'components/student_trial_exam_detail_container_view.dart';
import 'components/student_trial_exam_detail_menu.dart';
import 'cubit/student_trial_exam_detail_cubit.dart';

class AdminStudentsTrialExamDetailView extends AdminBaseView {
  const AdminStudentsTrialExamDetailView({this.student, Key? key}) : super(key: key);
  final Student? student;

  @override
  Widget get firstView => const StudentTrialExamDetailContainerView();

  @override
  Widget get secondView => StudentTrialExamDetailMenu(selectedStudent: student);

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
