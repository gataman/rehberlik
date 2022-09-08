// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter({GlobalKey<NavigatorState>? navigatorKey, required this.argumentsGuard}) : super(navigatorKey);

  final ArgumentsGuard argumentsGuard;

  @override
  final Map<String, PageFactory> pagesMap = {
    //DashBoard
    AdminDashboardRoute.name: (routeData) {
      final args = routeData.argsAs<AdminDashboardRouteArgs>(orElse: () => const AdminDashboardRouteArgs());
      return CustomPage<dynamic>(
          routeData: routeData,
          child: AdminDashboardView(key: args.key),
          transitionsBuilder: TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    //Classes
    AdminClassesRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const AdminClassesView(),
          transitionsBuilder: TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    //Students
    AdminStudentsRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const AdminStudentsView(),
          transitionsBuilder: TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    //Lessons
    AdminLessonsRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const AdminLessonsView(),
          transitionsBuilder: TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    //TrialExam
    AdminTrialExamRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const AdminTrialExamView(),
          transitionsBuilder: TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    //Uploads
    AdminUploadsRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const AdminUploadsView(),
          transitionsBuilder: TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    //Subjects
    AdminSubjectsRoute.name: (routeData) {
      final args = routeData.argsAs<AdminSubjectsRouteArgs>();
      return CustomPage<Lesson>(
          routeData: routeData,
          child: AdminSubjectsView(lesson: args.lesson, key: args.key),
          transitionsBuilder: TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    //StudentDetail
    AdminStudentDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AdminStudentDetailRouteArgs>();
      return CustomPage<Student>(
          routeData: routeData,
          child: AdminStudentDetailView(student: args.student, key: args.key),
          transitionsBuilder: TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },

    AdminTrialExamResultRoute.name: (routeData) {
      final args = routeData.argsAs<AdminTrialExamResultRouteArgs>();
      return CustomPage<TrialExam>(
          routeData: routeData,
          child: AdminTrialExamResultView(trialExam: args.trialExam, key: args.key),
          transitionsBuilder: TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect', path: '/', redirectTo: '/admin_dashboard', fullMatch: true),
        RouteConfig(AdminDashboardRoute.name, path: '/admin_dashboard'),
        RouteConfig(AdminClassesRoute.name, path: '/admin_classes'),
        RouteConfig(AdminStudentsRoute.name, path: '/admin_students'),
        RouteConfig(AdminLessonsRoute.name, path: '/admin_lessons'),
        RouteConfig(AdminTrialExamRoute.name, path: '/admin_trial_exams'),
        RouteConfig(AdminUploadsRoute.name, path: '/admin_uploads'),
        RouteConfig(AdminSubjectsRoute.name, path: '/admin_subject', guards: [argumentsGuard]),
        RouteConfig(AdminStudentDetailRoute.name, path: '/admin_student_detail', guards: [argumentsGuard]),
        RouteConfig(AdminTrialExamResultRoute.name,
            path: '/admin_trial_exam_result', guards: [argumentsGuard])
      ];
}

/// generated route for
/// [AdminDashboardView]
class AdminDashboardRoute extends PageRouteInfo<AdminDashboardRouteArgs> {
  AdminDashboardRoute({Key? key})
      : super(AdminDashboardRoute.name, path: '/admin_dashboard', args: AdminDashboardRouteArgs(key: key));

  static const String name = 'AdminDashboardRoute';
}

class AdminDashboardRouteArgs {
  const AdminDashboardRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AdminDashboardRouteArgs{key: $key}';
  }
}

/// generated route for
/// [AdminClassesView]
class AdminClassesRoute extends PageRouteInfo<void> {
  const AdminClassesRoute() : super(AdminClassesRoute.name, path: '/admin_classes');

  static const String name = 'AdminClassesRoute';
}

/// generated route for
/// [AdminStudentsView]
class AdminStudentsRoute extends PageRouteInfo<void> {
  const AdminStudentsRoute() : super(AdminStudentsRoute.name, path: '/admin_students');

  static const String name = 'AdminStudentsRoute';
}

/// generated route for
/// [AdminLessonsView]
class AdminLessonsRoute extends PageRouteInfo<void> {
  const AdminLessonsRoute() : super(AdminLessonsRoute.name, path: '/admin_lessons');

  static const String name = 'AdminLessonsRoute';
}

/// generated route for
/// [AdminTrialExamView]
class AdminTrialExamRoute extends PageRouteInfo<void> {
  const AdminTrialExamRoute() : super(AdminTrialExamRoute.name, path: '/admin_trial_exams');

  static const String name = 'AdminTrialExamRoute';
}

/// generated route for
/// [AdminUploadsView]
class AdminUploadsRoute extends PageRouteInfo<void> {
  const AdminUploadsRoute() : super(AdminUploadsRoute.name, path: '/admin_uploads');

  static const String name = 'AdminUploadsRoute';
}

/// generated route for
/// [AdminSubjectsView]
class AdminSubjectsRoute extends PageRouteInfo<AdminSubjectsRouteArgs> {
  AdminSubjectsRoute({required Lesson lesson, Key? key})
      : super(AdminSubjectsRoute.name,
            path: '/admin_subject', args: AdminSubjectsRouteArgs(lesson: lesson, key: key));

  static const String name = 'AdminSubjectsRoute';
}

class AdminSubjectsRouteArgs {
  const AdminSubjectsRouteArgs({required this.lesson, this.key});

  final Lesson lesson;

  final Key? key;

  @override
  String toString() {
    return 'AdminSubjectsRouteArgs{lesson: $lesson, key: $key}';
  }
}

/// generated route for
/// [AdminStudentDetailView]
class AdminStudentDetailRoute extends PageRouteInfo<AdminStudentDetailRouteArgs> {
  AdminStudentDetailRoute({required Student student, Key? key})
      : super(AdminStudentDetailRoute.name,
            path: '/admin_student_detail', args: AdminStudentDetailRouteArgs(student: student, key: key));

  static const String name = 'AdminStudentDetailRoute';
}

class AdminStudentDetailRouteArgs {
  const AdminStudentDetailRouteArgs({required this.student, this.key});

  final Student student;

  final Key? key;

  @override
  String toString() {
    return 'AdminStudentDetailRouteArgs{student: $student, key: $key}';
  }
}

/// generated route for
/// [AdminTrialExamResultView]
class AdminTrialExamResultRoute extends PageRouteInfo<AdminTrialExamResultRouteArgs> {
  AdminTrialExamResultRoute({required TrialExam trialExam, Key? key})
      : super(AdminTrialExamResultRoute.name,
            path: '/admin_trial_exam_result',
            args: AdminTrialExamResultRouteArgs(trialExam: trialExam, key: key));

  static const String name = 'AdminTrialExamResultRoute';
}

class AdminTrialExamResultRouteArgs {
  const AdminTrialExamResultRouteArgs({required this.trialExam, this.key});

  final TrialExam trialExam;

  final Key? key;

  @override
  String toString() {
    return 'AdminTrialExamResultArgs{trialExam: $trialExam, key: $key}';
  }
}
