import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/navigaton/admin_drawer_menu.dart';
import 'package:rehberlik/common/widgets/custom_app_bar.dart';

import 'admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'admin_dashboard/components/agenda_box/cubit/agenda_box_cubit.dart';
import 'admin_lessons/components/lesson_list_card/cubit/lesson_list_cubit.dart';
import 'admin_students/components/student_list_card/cubit/student_list_cubit.dart';

class AdminMainView extends StatelessWidget implements AutoRouteWrapper {
  const AdminMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
      ),
      drawer: const AdminDrawerMenu(),
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
        BlocProvider<StudentListCubit>(
          create: (_) => StudentListCubit(),
        ),
        BlocProvider<AgendaBoxCubit>(
          create: (_) => AgendaBoxCubit()..fetchAllMeetings(),
          lazy: false,
        ),
      ],
      child: this,
    );
  }
}
