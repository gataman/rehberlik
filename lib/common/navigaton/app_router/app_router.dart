import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/navigaton/app_router/guards/auth_guard.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_view.dart';
import 'package:rehberlik/views/admin/admin_dashboard/admin_dashboard_view.dart';
import 'package:rehberlik/views/admin/admin_lessons/admin_lessons_view.dart';
import 'package:rehberlik/views/admin/admin_main_view.dart';
import 'package:rehberlik/views/admin/admin_messages/admin_message_view.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_view.dart';
import 'package:rehberlik/views/admin/admin_students/admin_students_view.dart';
import 'package:rehberlik/views/admin/admin_subjects/admin_subjects_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam/admin_trial_exam_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/admin_trial_exam_result_view.dart';
import 'package:rehberlik/views/admin/admin_uploads/admin_uploads_view.dart';
import 'package:rehberlik/views/auth/auth_view.dart';
import 'package:rehberlik/views/splash_view.dart';

import '../../../models/student.dart';
import 'app_routes.dart';
import 'guards/arguments_guard.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    CustomRoute(
        page: AuthView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [AuthGuard],
        path: AppRoutes.routeMainAuth,
        initial: true),
    CustomRoute(
        page: AdminMainView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AppRoutes.routeMainAdmin,
        guards: [
          AuthGuard
        ],
        children: [
          CustomRoute(
              page: AdminDashboardView,
              path: AppRoutes.routeAdminDashboard,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [AuthGuard],
              initial: true),
          CustomRoute(
              page: AdminClassesView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [AuthGuard],
              path: AppRoutes.routeAdminClasses),
          CustomRoute(
              page: AdminStudentsView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [AuthGuard],
              path: AppRoutes.routeAdminStudents),
          CustomRoute(
              page: AdminLessonsView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [AuthGuard],
              path: AppRoutes.routeAdminLessons),
          CustomRoute(
              page: AdminTrialExamView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [AuthGuard],
              path: AppRoutes.routeAdminTrialExams),
          CustomRoute(
              page: AdminUploadsView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              guards: [AuthGuard],
              path: AppRoutes.routeAdminUploads),
          CustomRoute<Lesson>(
              page: AdminSubjectsView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              path: AppRoutes.routeAdminSubjects,
              guards: [ArgumentsGuard, AuthGuard]),
          CustomRoute<Student>(
              page: AdminStudentDetailView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              path: AppRoutes.routeAdminStudentDetail,
              guards: [ArgumentsGuard, AuthGuard]),
          CustomRoute<TrialExam>(
              page: AdminTrialExamResultView,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              path: AppRoutes.routeAdminTrialExamResult,
              guards: [ArgumentsGuard, AuthGuard]),
          CustomRoute(
            page: AdminMessageView,
            transitionsBuilder: TransitionsBuilders.fadeIn,
            path: AppRoutes.routeAdminMessages,
            guards: [AuthGuard],
          ),
        ]),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter({required ArgumentsGuard argumentsGuard, required AuthGuard authGuard})
      : super(argumentsGuard: argumentsGuard, authGuard: authGuard);
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
