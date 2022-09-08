import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/navigaton/admin_routes.dart';
import 'package:rehberlik/common/navigaton/guards/student_detail_guard.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_view.dart';
import 'package:rehberlik/views/admin/admin_dashboard/admin_dashboard_view.dart';
import 'package:rehberlik/views/admin/admin_lessons/admin_lessons_view.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_view.dart';
import 'package:rehberlik/views/admin/admin_students/admin_students_view.dart';
import 'package:rehberlik/views/admin/admin_subjects/admin_subjects_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam/admin_trial_exam_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/admin_trial_exam_result_view.dart';
import 'package:rehberlik/views/admin/admin_uploads/admin_uploads_view.dart';

import '../../models/student.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    CustomRoute(
        page: AdminDashboardView,
        path: AdminRoutes.routeDashboard,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        initial: true),
    CustomRoute(
        page: AdminClassesView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AdminRoutes.routeClasses),
    CustomRoute(
        page: AdminStudentsView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AdminRoutes.routeStudents),
    CustomRoute(
        page: AdminLessonsView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AdminRoutes.routeLessons),
    CustomRoute(
        page: AdminTrialExamView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AdminRoutes.routeTrialExams),
    CustomRoute(
        page: AdminUploadsView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AdminRoutes.routeUploads),
    CustomRoute<Lesson>(
        page: AdminSubjectsView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AdminRoutes.routeSubjects,
        guards: [ArgumentsGuard]),
    CustomRoute<Student>(
        page: AdminStudentDetailView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AdminRoutes.routeStudentDetail,
        guards: [ArgumentsGuard]),
    CustomRoute<TrialExam>(
        page: AdminTrialExamResultView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        path: AdminRoutes.routeTrialExamResult,
        guards: [ArgumentsGuard]),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter({required ArgumentsGuard argumentsGuard}) : super(argumentsGuard: argumentsGuard);
}
