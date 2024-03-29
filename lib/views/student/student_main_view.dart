import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/navigaton/app_router/student/student_drawer_menu.dart';
import '../../common/widgets/custom_app_bar.dart';
import '../../core/init/locale_manager.dart';
import '../../core/init/pref_keys.dart';
import '../../models/student.dart';
import '../admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import '../admin/admin_lessons/components/lesson_list_card/cubit/lesson_list_cubit.dart';
import '../admin/admin_student_detail/components/student_detail_tab_view/question_follow/cubit/question_follow_list_cubit.dart';
import '../admin/admin_student_detail/components/student_detail_tab_view/time_table/cubit/time_table_list_cubit.dart';
import '../admin/admin_student_trial_exam_detail_view/cubit/student_trial_exam_detail_cubit.dart';
import 'student_trial_exam_list/cubit/student_trial_exam_list_cubit.dart';

class StudentMainView extends StatelessWidget implements AutoRouteWrapper {
  const StudentMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        isStudent: true,
        appBarTitle: 'Öğrenci Paneli',
      ),
      drawer: const StudentDrawerMenu(),
      body: const AutoRouter(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final studentPref = SharedPrefs.instance.getString(PrefKeys.student.toString());
    final Student student = Student.fromJson(jsonDecode(studentPref!));
    //_fcmToken();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LessonListCubit>(
          create: (_) => LessonListCubit()..fetchLessonList(),
        ),
        BlocProvider<ClassListCubit>(
          create: (_) => ClassListCubit()..fetchClassList(),
          lazy: false,
        ),
        BlocProvider<TimeTableListCubit>(
          create: (_) => TimeTableListCubit()..fetchTimeTableList(student: student),
          lazy: false,
        ),
        BlocProvider<QuestionFollowListCubit>(
          create: (_) => QuestionFollowListCubit()..fetchQuestionFollowList(studentID: student.id!),
          lazy: false,
        ),
        BlocProvider<StudentTrialExamDetailCubit>(
          create: (_) => StudentTrialExamDetailCubit()..selectStudent(student),
          lazy: false,
        ),
        BlocProvider<StudentTrialExamListCubit>(
          create: (_) => StudentTrialExamListCubit()..fetchTrialExamList(classLevel: student.classLevel!),
          lazy: false,
        ),
      ],
      child: this,
    );
  }

  // void _fcmToken() async {
  //   final fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: vapidKey);
  //   debugPrint('Vapid: $fcmToken');
  // }
}
