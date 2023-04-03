import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/navigaton/app_router/teacher/teacher_drawer_menu.dart';
import '../../common/widgets/custom_app_bar.dart';
import '../admin/admin_base/cubit/teacher_cubit.dart';
import '../admin/admin_lessons/components/lesson_list_card/cubit/lesson_list_cubit.dart';
import '../admin/admin_students/components/student_list_card/cubit/student_list_cubit.dart';

class TeacherMainView extends StatelessWidget implements AutoRouteWrapper {
  const TeacherMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        appBarTitle: 'Öğretmen Paneli',
        isTeacher: true,
      ),
      drawer: const TeacherDrawerMenu(),
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
        BlocProvider<StudentListCubit>(
          create: (_) => StudentListCubit(),
        ),

        BlocProvider<TeacherCubit>(
          create: (_) => TeacherCubit()..setTeacherType(),
          lazy: false,
        ),
        // BlocProvider<FormExamCubit>(
        //   create: (_) => FormExamCubit(),
        //   lazy: false,
        // ),
      ],
      child: this,
    );
  }
}
