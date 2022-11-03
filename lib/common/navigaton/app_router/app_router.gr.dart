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
  _$AppRouter({
    GlobalKey<NavigatorState>? navigatorKey,
    required this.teacherAuthGuard,
    required this.studentAuthGuard,
    required this.argumentsGuard,
  }) : super(navigatorKey);

  final TeacherAuthGuard teacherAuthGuard;

  final StudentAuthGuard studentAuthGuard;

  final ArgumentsGuard argumentsGuard;

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const AuthView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StudentMainRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const StudentMainView()),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminMainRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const AdminMainView()),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StudentDashboardRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const StudentDashboardView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StudentQuestionFollowRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const StudentQuestionFollowView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminDashboardRoute.name: (routeData) {
      final args = routeData.argsAs<AdminDashboardRouteArgs>(
          orElse: () => const AdminDashboardRouteArgs());
      return CustomPage<dynamic>(
        routeData: routeData,
        child: AdminDashboardView(key: args.key),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminClassesRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const AdminClassesView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminStudentsRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const AdminStudentsView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminLessonsRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const AdminLessonsView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminTrialExamRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const AdminTrialExamView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminUploadsRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const AdminUploadsView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminSubjectsRoute.name: (routeData) {
      final args = routeData.argsAs<AdminSubjectsRouteArgs>();
      return CustomPage<Lesson>(
        routeData: routeData,
        child: AdminSubjectsView(
          lesson: args.lesson,
          key: args.key,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminStudentDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AdminStudentDetailRouteArgs>();
      return CustomPage<Student>(
        routeData: routeData,
        child: AdminStudentDetailView(
          student: args.student,
          key: args.key,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminTrialExamResultRoute.name: (routeData) {
      final args = routeData.argsAs<AdminTrialExamResultRouteArgs>();
      return CustomPage<TrialExam>(
        routeData: routeData,
        child: AdminTrialExamResultView(
          trialExam: args.trialExam,
          key: args.key,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminMessageRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const AdminMessageView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminStudentsTrialExamDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AdminStudentsTrialExamDetailRouteArgs>(
          orElse: () => const AdminStudentsTrialExamDetailRouteArgs());
      return CustomPage<Student?>(
        routeData: routeData,
        child: AdminStudentsTrialExamDetailView(
          student: args.student,
          key: args.key,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminStudentsPasswordRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const AdminStudentsPasswordView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/auth',
          fullMatch: true,
        ),
        RouteConfig(
          AuthRoute.name,
          path: '/auth',
          guards: [teacherAuthGuard],
        ),
        RouteConfig(
          StudentMainRoute.name,
          path: '/student',
          guards: [studentAuthGuard],
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: StudentMainRoute.name,
              redirectTo: 'dashboard',
              fullMatch: true,
            ),
            RouteConfig(
              StudentDashboardRoute.name,
              path: 'dashboard',
              parent: StudentMainRoute.name,
              guards: [studentAuthGuard],
            ),
            RouteConfig(
              StudentQuestionFollowRoute.name,
              path: 'soru_takibi',
              parent: StudentMainRoute.name,
              guards: [studentAuthGuard],
            ),
          ],
        ),
        RouteConfig(
          AdminMainRoute.name,
          path: '/admin',
          guards: [teacherAuthGuard],
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: AdminMainRoute.name,
              redirectTo: 'dashboard',
              fullMatch: true,
            ),
            RouteConfig(
              AdminDashboardRoute.name,
              path: 'dashboard',
              parent: AdminMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminClassesRoute.name,
              path: 'classes',
              parent: AdminMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminStudentsRoute.name,
              path: 'students',
              parent: AdminMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminLessonsRoute.name,
              path: 'lessons',
              parent: AdminMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminTrialExamRoute.name,
              path: 'trial_exams',
              parent: AdminMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminUploadsRoute.name,
              path: 'uploads',
              parent: AdminMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminSubjectsRoute.name,
              path: 'subjects',
              parent: AdminMainRoute.name,
              guards: [
                argumentsGuard,
                teacherAuthGuard,
              ],
            ),
            RouteConfig(
              AdminStudentDetailRoute.name,
              path: 'student_detail',
              parent: AdminMainRoute.name,
              guards: [
                argumentsGuard,
                teacherAuthGuard,
              ],
            ),
            RouteConfig(
              AdminTrialExamResultRoute.name,
              path: 'trial_exam_result',
              parent: AdminMainRoute.name,
              guards: [
                argumentsGuard,
                teacherAuthGuard,
              ],
            ),
            RouteConfig(
              AdminMessageRoute.name,
              path: 'messages',
              parent: AdminMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminStudentsTrialExamDetailRoute.name,
              path: 'students_trial_exam_detail',
              parent: AdminMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminStudentsPasswordRoute.name,
              path: 'students_password',
              parent: AdminMainRoute.name,
              guards: [teacherAuthGuard],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [AuthView]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: '/auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [StudentMainView]
class StudentMainRoute extends PageRouteInfo<void> {
  const StudentMainRoute({List<PageRouteInfo>? children})
      : super(
          StudentMainRoute.name,
          path: '/student',
          initialChildren: children,
        );

  static const String name = 'StudentMainRoute';
}

/// generated route for
/// [AdminMainView]
class AdminMainRoute extends PageRouteInfo<void> {
  const AdminMainRoute({List<PageRouteInfo>? children})
      : super(
          AdminMainRoute.name,
          path: '/admin',
          initialChildren: children,
        );

  static const String name = 'AdminMainRoute';
}

/// generated route for
/// [StudentDashboardView]
class StudentDashboardRoute extends PageRouteInfo<void> {
  const StudentDashboardRoute()
      : super(
          StudentDashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'StudentDashboardRoute';
}

/// generated route for
/// [StudentQuestionFollowView]
class StudentQuestionFollowRoute extends PageRouteInfo<void> {
  const StudentQuestionFollowRoute()
      : super(
          StudentQuestionFollowRoute.name,
          path: 'soru_takibi',
        );

  static const String name = 'StudentQuestionFollowRoute';
}

/// generated route for
/// [AdminDashboardView]
class AdminDashboardRoute extends PageRouteInfo<AdminDashboardRouteArgs> {
  AdminDashboardRoute({Key? key})
      : super(
          AdminDashboardRoute.name,
          path: 'dashboard',
          args: AdminDashboardRouteArgs(key: key),
        );

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
  const AdminClassesRoute()
      : super(
          AdminClassesRoute.name,
          path: 'classes',
        );

  static const String name = 'AdminClassesRoute';
}

/// generated route for
/// [AdminStudentsView]
class AdminStudentsRoute extends PageRouteInfo<void> {
  const AdminStudentsRoute()
      : super(
          AdminStudentsRoute.name,
          path: 'students',
        );

  static const String name = 'AdminStudentsRoute';
}

/// generated route for
/// [AdminLessonsView]
class AdminLessonsRoute extends PageRouteInfo<void> {
  const AdminLessonsRoute()
      : super(
          AdminLessonsRoute.name,
          path: 'lessons',
        );

  static const String name = 'AdminLessonsRoute';
}

/// generated route for
/// [AdminTrialExamView]
class AdminTrialExamRoute extends PageRouteInfo<void> {
  const AdminTrialExamRoute()
      : super(
          AdminTrialExamRoute.name,
          path: 'trial_exams',
        );

  static const String name = 'AdminTrialExamRoute';
}

/// generated route for
/// [AdminUploadsView]
class AdminUploadsRoute extends PageRouteInfo<void> {
  const AdminUploadsRoute()
      : super(
          AdminUploadsRoute.name,
          path: 'uploads',
        );

  static const String name = 'AdminUploadsRoute';
}

/// generated route for
/// [AdminSubjectsView]
class AdminSubjectsRoute extends PageRouteInfo<AdminSubjectsRouteArgs> {
  AdminSubjectsRoute({
    required Lesson lesson,
    Key? key,
  }) : super(
          AdminSubjectsRoute.name,
          path: 'subjects',
          args: AdminSubjectsRouteArgs(
            lesson: lesson,
            key: key,
          ),
        );

  static const String name = 'AdminSubjectsRoute';
}

class AdminSubjectsRouteArgs {
  const AdminSubjectsRouteArgs({
    required this.lesson,
    this.key,
  });

  final Lesson lesson;

  final Key? key;

  @override
  String toString() {
    return 'AdminSubjectsRouteArgs{lesson: $lesson, key: $key}';
  }
}

/// generated route for
/// [AdminStudentDetailView]
class AdminStudentDetailRoute
    extends PageRouteInfo<AdminStudentDetailRouteArgs> {
  AdminStudentDetailRoute({
    required Student student,
    Key? key,
  }) : super(
          AdminStudentDetailRoute.name,
          path: 'student_detail',
          args: AdminStudentDetailRouteArgs(
            student: student,
            key: key,
          ),
        );

  static const String name = 'AdminStudentDetailRoute';
}

class AdminStudentDetailRouteArgs {
  const AdminStudentDetailRouteArgs({
    required this.student,
    this.key,
  });

  final Student student;

  final Key? key;

  @override
  String toString() {
    return 'AdminStudentDetailRouteArgs{student: $student, key: $key}';
  }
}

/// generated route for
/// [AdminTrialExamResultView]
class AdminTrialExamResultRoute
    extends PageRouteInfo<AdminTrialExamResultRouteArgs> {
  AdminTrialExamResultRoute({
    required TrialExam trialExam,
    Key? key,
  }) : super(
          AdminTrialExamResultRoute.name,
          path: 'trial_exam_result',
          args: AdminTrialExamResultRouteArgs(
            trialExam: trialExam,
            key: key,
          ),
        );

  static const String name = 'AdminTrialExamResultRoute';
}

class AdminTrialExamResultRouteArgs {
  const AdminTrialExamResultRouteArgs({
    required this.trialExam,
    this.key,
  });

  final TrialExam trialExam;

  final Key? key;

  @override
  String toString() {
    return 'AdminTrialExamResultRouteArgs{trialExam: $trialExam, key: $key}';
  }
}

/// generated route for
/// [AdminMessageView]
class AdminMessageRoute extends PageRouteInfo<void> {
  const AdminMessageRoute()
      : super(
          AdminMessageRoute.name,
          path: 'messages',
        );

  static const String name = 'AdminMessageRoute';
}

/// generated route for
/// [AdminStudentsTrialExamDetailView]
class AdminStudentsTrialExamDetailRoute
    extends PageRouteInfo<AdminStudentsTrialExamDetailRouteArgs> {
  AdminStudentsTrialExamDetailRoute({
    Student? student,
    Key? key,
  }) : super(
          AdminStudentsTrialExamDetailRoute.name,
          path: 'students_trial_exam_detail',
          args: AdminStudentsTrialExamDetailRouteArgs(
            student: student,
            key: key,
          ),
        );

  static const String name = 'AdminStudentsTrialExamDetailRoute';
}

class AdminStudentsTrialExamDetailRouteArgs {
  const AdminStudentsTrialExamDetailRouteArgs({
    this.student,
    this.key,
  });

  final Student? student;

  final Key? key;

  @override
  String toString() {
    return 'AdminStudentsTrialExamDetailRouteArgs{student: $student, key: $key}';
  }
}

/// generated route for
/// [AdminStudentsPasswordView]
class AdminStudentsPasswordRoute extends PageRouteInfo<void> {
  const AdminStudentsPasswordRoute()
      : super(
          AdminStudentsPasswordRoute.name,
          path: 'students_password',
        );

  static const String name = 'AdminStudentsPasswordRoute';
}
