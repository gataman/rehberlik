import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/navigaton/admin_routes.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_binding.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_view.dart';
import 'package:rehberlik/views/admin/admin_dashboard/admin_dashboard_binding.dart';
import 'package:rehberlik/views/admin/admin_dashboard/admin_dashboard_view.dart';
import 'package:rehberlik/views/admin/admin_lessons/admin_lessons_view.dart';
import 'package:rehberlik/views/admin/admin_messages/admin_message_binding.dart';
import 'package:rehberlik/views/admin/admin_messages/admin_message_view.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_binding.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_view.dart';
import 'package:rehberlik/views/admin/admin_students/admin_students_binding.dart';
import 'package:rehberlik/views/admin/admin_students/admin_students_view.dart';
import 'package:rehberlik/views/admin/admin_subjects/admin_subjects_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam/admin_trial_exam_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/admin_trial_exam_result_binding.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/admin_trial_exam_result_view.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/components/admin_trial_exam_excel_import_view.dart';
import 'package:rehberlik/views/admin/admin_uploads/admin_uploads_binding.dart';
import 'package:rehberlik/views/admin/admin_uploads/admin_uploads_view.dart';

class AppPages {
  static const initial = AdminRoutes.routeDashboard;

  static final adminPages = [
    GetPage(
      name: AdminRoutes.routeDashboard,
      page: () => AdminDashboardView(),
      binding: AdminDashboardViewBinding(),
    ),
    GetPage(
      name: AdminRoutes.routeClasses,
      page: () => const AdminClassesView(),
      binding: AdminClassesBinding(),
    ),
    GetPage(
      name: AdminRoutes.routeStudents,
      page: () => const AdminStudentsView(),
      binding: AdminStudentsBinding(),
    ),
    GetPage(
      name: AdminRoutes.routeStudentDetail,
      page: () => const AdminStudentDetailView(),
      binding: AdminStudentDetailBinding(),
    ),
    GetPage(
      name: AdminRoutes.routeLessons,
      page: () => const AdminLessonsView(),
    ),
    GetPage(
      name: AdminRoutes.routeSubjects,
      page: () => const AdminSubjectsView(),
    ),
    GetPage(
      name: AdminRoutes.routeMessages,
      page: () => const AdminMessageView(),
      binding: AdminMessageBinding(),
    ),
    GetPage(
      name: AdminRoutes.routeUploads,
      page: () => const AdminUploadsView(),
      binding: AdminUploadsBinding(),
    ),
    GetPage(
      name: AdminRoutes.routeTrialExams,
      page: () => const AdminTrialExamView(),
    ),
    GetPage(
      name: AdminRoutes.routeTrialExamResult,
      page: () => const AdminTrialExamResultView(),
      binding: AdminTrialExamResultBinding(),
    ),
    GetPage(
      name: AdminRoutes.routeTrialExamExcelImport,
      page: () => const AdminTrialExamExcelImportView(),
    ),
  ];

  static Route<dynamic>? onGenerateRoute(settings) {
    var pageRoute = GetPageRoute(
      routeName: AdminRoutes.routeDashboard,
      page: () => AdminDashboardView(),
      binding: AdminDashboardViewBinding(),
    );

    switch (settings.name!) {
      case AdminRoutes.routeDashboard:
        pageRoute = GetPageRoute(
          routeName: AdminRoutes.routeDashboard,
          page: () => AdminDashboardView(),
          binding: AdminDashboardViewBinding(),
        );
        break;
      case AdminRoutes.routeClasses:
        pageRoute = GetPageRoute(
          routeName: AdminRoutes.routeClasses,
          page: () => const AdminClassesView(),
          binding: AdminClassesBinding(),
        );
        break;
      case AdminRoutes.routeStudents:
        pageRoute = GetPageRoute(
          routeName: AdminRoutes.routeStudents,
          page: () => const AdminStudentsView(),
          binding: AdminStudentsBinding(),
        );
        break;
      case AdminRoutes.routeStudentDetail:
        pageRoute = GetPageRoute(
          routeName: AdminRoutes.routeStudentDetail,
          page: () => const AdminStudentDetailView(),
          binding: AdminStudentDetailBinding(),
        );
        break;
      case AdminRoutes.routeLessons:
        pageRoute = GetPageRoute(
          routeName: AdminRoutes.routeLessons,
          page: () => const AdminLessonsView(),
        );
        break;

      case AdminRoutes.routeSubjects:
        pageRoute = GetPageRoute(
          page: () => Get.put(const AdminSubjectsView()),
        );
        break;
      case AdminRoutes.routeMessages:
        pageRoute = GetPageRoute(
          page: () => const AdminMessageView(),
          binding: AdminMessageBinding(),
        );
        break;

      case AdminRoutes.routeUploads:
        pageRoute = GetPageRoute(
          page: () => const AdminUploadsView(),
          binding: AdminUploadsBinding(),
        );
        break;

      case AdminRoutes.routeTrialExams:
        pageRoute = GetPageRoute(
          page: () => const AdminTrialExamView(),
        );
        break;

      case AdminRoutes.routeTrialExamResult:
        pageRoute = GetPageRoute(
            page: () => const AdminTrialExamResultView(),
            binding: AdminTrialExamResultBinding());

        break;

      case AdminRoutes.routeTrialExamExcelImport:
        pageRoute = GetPageRoute(
          page: () => const AdminTrialExamExcelImportView(),
        );
        break;
    }
    return pageRoute;
  }
}
