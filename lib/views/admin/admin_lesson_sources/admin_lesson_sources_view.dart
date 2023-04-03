import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/student_lesson_sources_menu.dart';
import 'cubit/lesson_sources_cubit.dart';

import '../../../models/student.dart';
import '../admin_base/admin_base_view.dart';
import 'components/student_lesson_sources_container_view.dart';

class AdminLessonSourcesView extends AdminBaseView {
  const AdminLessonSourcesView({this.student, Key? key}) : super(key: key);
  final Student? student;

  @override
  Widget get firstView => const StudentLessonSourcesContainerView();

  @override
  Widget get secondView => StudentLessonSourcesMenu(selectedStudent: student);

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<LessonSourcesCubit>(
        create: (_) => LessonSourcesCubit(),
      ),
    ];
    return providers;
  }
}
