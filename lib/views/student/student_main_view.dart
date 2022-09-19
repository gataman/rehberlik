import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/navigaton/app_router/student/student_drawer_menu.dart';
import 'package:rehberlik/common/widgets/student_app_bar.dart';

import '../admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import '../admin/admin_lessons/components/lesson_list_card/cubit/lesson_list_cubit.dart';

class StudentMainView extends StatelessWidget implements AutoRouteWrapper {
  const StudentMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudentAppBar(),
      drawer: const StudentDrawerMenu(),
      body: const AutoRouter(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LessonListCubit>(
          create: (_) => LessonListCubit()..fetchLessonList(),
        ),
        BlocProvider<ClassListCubit>(
          create: (_) => ClassListCubit()..fetchClassList(),
          lazy: false,
        ),
      ],
      child: this,
    );
  }
}
