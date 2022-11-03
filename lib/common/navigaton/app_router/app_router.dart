import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/navigaton/app_router/guards/teacher_auth_guard.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_view.dart';
import 'package:rehberlik/views/admin/admin_dashboard/admin_dashboard_view.dart';
import 'package:rehberlik/views/admin/admin_lessons/admin_lessons_view.dart';
import 'package:rehberlik/views/admin/admin_main_view.dart';
import 'package:rehberlik/views/admin/admin_messages/admin_message_view.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_view.dart';
import 'package:rehberlik/views/admin/admin_students/admin_students_view.dart';
import 'package:rehberlik/views/admin/admin_students_password/admin_students_pasword_view.dart';
import 'package:rehberlik/views/admin/admin_subjects/admin_subjects_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam/admin_trial_exam_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/admin_trial_exam_result_view.dart';
import 'package:rehberlik/views/admin/admin_uploads/admin_uploads_view.dart';
import 'package:rehberlik/views/auth/auth_view.dart';
import 'package:rehberlik/views/student/student_main_view.dart';

import '../../../models/student.dart';
import '../../../views/admin/admin_student_trial_exam_detail_view/admin_students_trial_exam_detail_view.dart';
import '../../../views/student/student_dashboard/student_dashboard_view.dart';
import '../../../views/student/student_question_follow/student_question_follow_view.dart';
import 'app_routes.dart';
import 'guards/arguments_guard.dart';
import 'guards/student_auth_guard.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    CustomRoute(
        page: AuthView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [TeacherAuthGuard],
        path: AppRoutes.routeMainAuth,
        initial: true),
    CustomRoute(
        page: StudentMainView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AppRoutes.routeMainStudent,
        guards: [
          StudentAuthGuard
        ],
        children: [
          CustomRoute(
              page: StudentDashboardView,
              path: AppRoutes.routeStudentDashboard,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [StudentAuthGuard],
              initial: true),
          CustomRoute(
              page: StudentQuestionFollowView,
              path: AppRoutes.routeStudentQuestionFollow,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [StudentAuthGuard]),
        ]),
    CustomRoute(
        page: AdminMainView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AppRoutes.routeMainAdmin,
        guards: [
          TeacherAuthGuard
        ],
        children: [
          CustomRoute(
              page: AdminDashboardView,
              path: AppRoutes.routeAdminDashboard,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [TeacherAuthGuard],
              initial: true),
          CustomRoute(
              page: AdminClassesView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [TeacherAuthGuard],
              path: AppRoutes.routeAdminClasses),
          CustomRoute(
              page: AdminStudentsView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [TeacherAuthGuard],
              path: AppRoutes.routeAdminStudents),
          CustomRoute(
              page: AdminLessonsView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [TeacherAuthGuard],
              path: AppRoutes.routeAdminLessons),
          CustomRoute(
              page: AdminTrialExamView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [TeacherAuthGuard],
              path: AppRoutes.routeAdminTrialExams),
          CustomRoute(
              page: AdminUploadsView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [TeacherAuthGuard],
              path: AppRoutes.routeAdminUploads),
          CustomRoute<Lesson>(
              page: AdminSubjectsView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              path: AppRoutes.routeAdminSubjects,
              guards: [ArgumentsGuard, TeacherAuthGuard]),
          CustomRoute<Student>(
              page: AdminStudentDetailView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              path: AppRoutes.routeAdminStudentDetail,
              guards: [ArgumentsGuard, TeacherAuthGuard]),
          CustomRoute<TrialExam>(
              page: AdminTrialExamResultView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              path: AppRoutes.routeAdminTrialExamResult,
              guards: [ArgumentsGuard, TeacherAuthGuard]),
          CustomRoute(
            page: AdminMessageView,
            transitionsBuilder: TransitionsBuilders.fadeIn,
            path: AppRoutes.routeAdminMessages,
            guards: [TeacherAuthGuard],
          ),
          CustomRoute<Student?>(
            page: AdminStudentsTrialExamDetailView,
            transitionsBuilder: TransitionsBuilders.fadeIn,
            path: AppRoutes.routeAdminStudentsTrialExamDetailView,
            guards: [TeacherAuthGuard],
          ),
          CustomRoute(
              page: AdminStudentsPasswordView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [TeacherAuthGuard],
              path: AppRoutes.routeAdminStudentsPassword),
        ]),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter({
    required ArgumentsGuard argumentsGuard,
    required TeacherAuthGuard teacherAuthGuard,
    required StudentAuthGuard studentAuthGuard,
  }) : super(
          argumentsGuard: argumentsGuard,
          teacherAuthGuard: teacherAuthGuard,
          studentAuthGuard: studentAuthGuard,
        );
}

/*
 CustomRoute(
        page: AdminDashboardView,
        path: AppRoutes.routeDashboard,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        initial: true),
    CustomRoute(page: AdminClassesView, transitionsBuilder: TransitionsBuilders.fadeIn, path: AppRoutes.routeClasses),
    CustomRoute(page: AdminStudentsView, transitionsBuilder: TransitionsBuilders.fadeIn, path: AppRoutes.routeStudents),
    CustomRoute(page: AdminLessonsView, transitionsBuilder: TransitionsBuilders.fadeIn, path: AppRoutes.routeLessons),
    CustomRoute(
        page: AdminTrialExamView, transitionsBuilder: TransitionsBuilders.fadeIn, path: AppRoutes.routeTrialExams),
    CustomRoute(page: AdminUploadsView, transitionsBuilder: TransitionsBuilders.fadeIn, path: AppRoutes.routeUploads),
    CustomRoute<Lesson>(
        page: AdminSubjectsView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AppRoutes.routeSubjects,
        guards: [ArgumentsGuard]),
    CustomRoute<Student>(
        page: AdminStudentDetailView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AppRoutes.routeStudentDetail,
        guards: [ArgumentsGuard]),
    CustomRoute<TrialExam>(
        page: AdminTrialExamResultView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AppRoutes.routeTrialExamResult,
        guards: [ArgumentsGuard]),
    CustomRoute(
      page: AdminMessageView,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      path: AppRoutes.routeMessages,
    ),
    */
