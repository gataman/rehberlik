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
    required this.authGuard,
    required this.studentAuthGuard,
    required this.adminAuthGuard,
    required this.teacherAuthGuard,
    required this.argumentsGuard,
  }) : super(navigatorKey);

  final AuthGuard authGuard;

  final StudentAuthGuard studentAuthGuard;

  final AdminAuthGuard adminAuthGuard;

  final TeacherAuthGuard teacherAuthGuard;

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
    TeacherMainRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const TeacherMainView()),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StudentTrialExamListRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const StudentTrialExamListView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StudentTrialExamRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const StudentTrialExamView(),
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
    StudentExamDetailRoute.name: (routeData) {
      final args = routeData.argsAs<StudentExamDetailRouteArgs>();
      return CustomPage<TrialExam>(
        routeData: routeData,
        child: StudentExamDetailView(
          trialExam: args.trialExam,
          key: args.key,
        ),
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
      return CustomPage<LessonWithSubject>(
        routeData: routeData,
        child: AdminSubjectsView(
          lessonWithSubject: args.lessonWithSubject,
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
    AdminTrialExamTotalRoute.name: (routeData) {
      final args = routeData.argsAs<AdminTrialExamTotalRouteArgs>();
      return CustomPage<int>(
        routeData: routeData,
        child: AdminTrialExamTotalView(
          classLevel: args.classLevel,
          key: args.key,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminTrialExamSingleResultRoute.name: (routeData) {
      final args = routeData.argsAs<AdminTrialExamSingleResultRouteArgs>();
      return CustomPage<TrialExamResult>(
        routeData: routeData,
        child: AdminTrialExamSingleResultView(
          key: args.key,
          trialExamResult: args.trialExamResult,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminQuizzesRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const AdminQuizzesView(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AdminLessonSourcesRoute.name: (routeData) {
      final args = routeData.argsAs<AdminLessonSourcesRouteArgs>(
          orElse: () => const AdminLessonSourcesRouteArgs());
      return CustomPage<Student?>(
        routeData: routeData,
        child: AdminLessonSourcesView(
          student: args.student,
          key: args.key,
        ),
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
          guards: [authGuard],
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
              redirectTo: 'deneme_sinav_listesi',
              fullMatch: true,
            ),
            RouteConfig(
              StudentTrialExamListRoute.name,
              path: 'deneme_sinav_listesi',
              parent: StudentMainRoute.name,
              guards: [studentAuthGuard],
            ),
            RouteConfig(
              StudentTrialExamRoute.name,
              path: 'deneme_sinavlari',
              parent: StudentMainRoute.name,
              guards: [studentAuthGuard],
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
            RouteConfig(
              StudentExamDetailRoute.name,
              path: 'deneme_detayi',
              parent: StudentMainRoute.name,
              guards: [
                argumentsGuard,
                studentAuthGuard,
              ],
            ),
          ],
        ),
        RouteConfig(
          AdminMainRoute.name,
          path: '/admin',
          guards: [adminAuthGuard],
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
              guards: [adminAuthGuard],
            ),
            RouteConfig(
              AdminClassesRoute.name,
              path: 'classes',
              parent: AdminMainRoute.name,
              guards: [adminAuthGuard],
            ),
            RouteConfig(
              AdminStudentsRoute.name,
              path: 'students',
              parent: AdminMainRoute.name,
              guards: [adminAuthGuard],
            ),
            RouteConfig(
              AdminLessonsRoute.name,
              path: 'lessons',
              parent: AdminMainRoute.name,
              guards: [adminAuthGuard],
            ),
            RouteConfig(
              AdminTrialExamRoute.name,
              path: 'trial_exams',
              parent: AdminMainRoute.name,
              guards: [adminAuthGuard],
            ),
            RouteConfig(
              AdminUploadsRoute.name,
              path: 'uploads',
              parent: AdminMainRoute.name,
              guards: [adminAuthGuard],
            ),
            RouteConfig(
              AdminSubjectsRoute.name,
              path: 'subjects',
              parent: AdminMainRoute.name,
              guards: [
                argumentsGuard,
                adminAuthGuard,
              ],
            ),
            RouteConfig(
              AdminStudentDetailRoute.name,
              path: 'student_detail',
              parent: AdminMainRoute.name,
              guards: [
                argumentsGuard,
                adminAuthGuard,
              ],
            ),
            RouteConfig(
              AdminTrialExamResultRoute.name,
              path: 'trial_exam_result',
              parent: AdminMainRoute.name,
              guards: [
                argumentsGuard,
                adminAuthGuard,
              ],
            ),
            RouteConfig(
              AdminMessageRoute.name,
              path: 'messages',
              parent: AdminMainRoute.name,
              guards: [adminAuthGuard],
            ),
            RouteConfig(
              AdminStudentsTrialExamDetailRoute.name,
              path: 'students_trial_exam_detail',
              parent: AdminMainRoute.name,
              guards: [adminAuthGuard],
            ),
            RouteConfig(
              AdminStudentsPasswordRoute.name,
              path: 'students_password',
              parent: AdminMainRoute.name,
              guards: [adminAuthGuard],
            ),
            RouteConfig(
              AdminTrialExamTotalRoute.name,
              path: 'trial_exam_total_average',
              parent: AdminMainRoute.name,
              guards: [
                argumentsGuard,
                adminAuthGuard,
              ],
            ),
            RouteConfig(
              AdminTrialExamSingleResultRoute.name,
              path: 'trial_exam_single_view',
              parent: AdminMainRoute.name,
              guards: [
                argumentsGuard,
                adminAuthGuard,
              ],
            ),
            RouteConfig(
              AdminQuizzesRoute.name,
              path: 'admin_quizzes',
              parent: AdminMainRoute.name,
              guards: [adminAuthGuard],
            ),
            RouteConfig(
              AdminLessonSourcesRoute.name,
              path: 'lesson_sources_view',
              parent: AdminMainRoute.name,
              guards: [adminAuthGuard],
            ),
          ],
        ),
        RouteConfig(
          TeacherMainRoute.name,
          path: '/teacher',
          guards: [teacherAuthGuard],
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: TeacherMainRoute.name,
              redirectTo: 'trial_exams',
              fullMatch: true,
            ),
            RouteConfig(
              AdminTrialExamRoute.name,
              path: 'trial_exams',
              parent: TeacherMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminClassesRoute.name,
              path: 'classes',
              parent: TeacherMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminStudentsRoute.name,
              path: 'students',
              parent: TeacherMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminStudentDetailRoute.name,
              path: 'student_detail',
              parent: TeacherMainRoute.name,
              guards: [
                argumentsGuard,
                teacherAuthGuard,
              ],
            ),
            RouteConfig(
              AdminStudentsTrialExamDetailRoute.name,
              path: 'students_trial_exam_detail',
              parent: TeacherMainRoute.name,
              guards: [teacherAuthGuard],
            ),
            RouteConfig(
              AdminTrialExamResultRoute.name,
              path: 'trial_exam_result',
              parent: TeacherMainRoute.name,
              guards: [
                argumentsGuard,
                teacherAuthGuard,
              ],
            ),
            RouteConfig(
              AdminTrialExamTotalRoute.name,
              path: 'trial_exam_total_average',
              parent: TeacherMainRoute.name,
              guards: [
                argumentsGuard,
                teacherAuthGuard,
              ],
            ),
            RouteConfig(
              AdminTrialExamSingleResultRoute.name,
              path: 'trial_exam_single_view',
              parent: TeacherMainRoute.name,
              guards: [
                argumentsGuard,
                teacherAuthGuard,
              ],
            ),
            RouteConfig(
              AdminStudentsPasswordRoute.name,
              path: 'students_password',
              parent: TeacherMainRoute.name,
              guards: [adminAuthGuard],
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
/// [TeacherMainView]
class TeacherMainRoute extends PageRouteInfo<void> {
  const TeacherMainRoute({List<PageRouteInfo>? children})
      : super(
          TeacherMainRoute.name,
          path: '/teacher',
          initialChildren: children,
        );

  static const String name = 'TeacherMainRoute';
}

/// generated route for
/// [StudentTrialExamListView]
class StudentTrialExamListRoute extends PageRouteInfo<void> {
  const StudentTrialExamListRoute()
      : super(
          StudentTrialExamListRoute.name,
          path: 'deneme_sinav_listesi',
        );

  static const String name = 'StudentTrialExamListRoute';
}

/// generated route for
/// [StudentTrialExamView]
class StudentTrialExamRoute extends PageRouteInfo<void> {
  const StudentTrialExamRoute()
      : super(
          StudentTrialExamRoute.name,
          path: 'deneme_sinavlari',
        );

  static const String name = 'StudentTrialExamRoute';
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
/// [StudentExamDetailView]
class StudentExamDetailRoute extends PageRouteInfo<StudentExamDetailRouteArgs> {
  StudentExamDetailRoute({
    required TrialExam trialExam,
    Key? key,
  }) : super(
          StudentExamDetailRoute.name,
          path: 'deneme_detayi',
          args: StudentExamDetailRouteArgs(
            trialExam: trialExam,
            key: key,
          ),
        );

  static const String name = 'StudentExamDetailRoute';
}

class StudentExamDetailRouteArgs {
  const StudentExamDetailRouteArgs({
    required this.trialExam,
    this.key,
  });

  final TrialExam trialExam;

  final Key? key;

  @override
  String toString() {
    return 'StudentExamDetailRouteArgs{trialExam: $trialExam, key: $key}';
  }
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
    required LessonWithSubject lessonWithSubject,
    Key? key,
  }) : super(
          AdminSubjectsRoute.name,
          path: 'subjects',
          args: AdminSubjectsRouteArgs(
            lessonWithSubject: lessonWithSubject,
            key: key,
          ),
        );

  static const String name = 'AdminSubjectsRoute';
}

class AdminSubjectsRouteArgs {
  const AdminSubjectsRouteArgs({
    required this.lessonWithSubject,
    this.key,
  });

  final LessonWithSubject lessonWithSubject;

  final Key? key;

  @override
  String toString() {
    return 'AdminSubjectsRouteArgs{lessonWithSubject: $lessonWithSubject, key: $key}';
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

/// generated route for
/// [AdminTrialExamTotalView]
class AdminTrialExamTotalRoute
    extends PageRouteInfo<AdminTrialExamTotalRouteArgs> {
  AdminTrialExamTotalRoute({
    required int classLevel,
    Key? key,
  }) : super(
          AdminTrialExamTotalRoute.name,
          path: 'trial_exam_total_average',
          args: AdminTrialExamTotalRouteArgs(
            classLevel: classLevel,
            key: key,
          ),
        );

  static const String name = 'AdminTrialExamTotalRoute';
}

class AdminTrialExamTotalRouteArgs {
  const AdminTrialExamTotalRouteArgs({
    required this.classLevel,
    this.key,
  });

  final int classLevel;

  final Key? key;

  @override
  String toString() {
    return 'AdminTrialExamTotalRouteArgs{classLevel: $classLevel, key: $key}';
  }
}

/// generated route for
/// [AdminTrialExamSingleResultView]
class AdminTrialExamSingleResultRoute
    extends PageRouteInfo<AdminTrialExamSingleResultRouteArgs> {
  AdminTrialExamSingleResultRoute({
    Key? key,
    required TrialExamResult trialExamResult,
  }) : super(
          AdminTrialExamSingleResultRoute.name,
          path: 'trial_exam_single_view',
          args: AdminTrialExamSingleResultRouteArgs(
            key: key,
            trialExamResult: trialExamResult,
          ),
        );

  static const String name = 'AdminTrialExamSingleResultRoute';
}

class AdminTrialExamSingleResultRouteArgs {
  const AdminTrialExamSingleResultRouteArgs({
    this.key,
    required this.trialExamResult,
  });

  final Key? key;

  final TrialExamResult trialExamResult;

  @override
  String toString() {
    return 'AdminTrialExamSingleResultRouteArgs{key: $key, trialExamResult: $trialExamResult}';
  }
}

/// generated route for
/// [AdminQuizzesView]
class AdminQuizzesRoute extends PageRouteInfo<void> {
  const AdminQuizzesRoute()
      : super(
          AdminQuizzesRoute.name,
          path: 'admin_quizzes',
        );

  static const String name = 'AdminQuizzesRoute';
}

/// generated route for
/// [AdminLessonSourcesView]
class AdminLessonSourcesRoute
    extends PageRouteInfo<AdminLessonSourcesRouteArgs> {
  AdminLessonSourcesRoute({
    Student? student,
    Key? key,
  }) : super(
          AdminLessonSourcesRoute.name,
          path: 'lesson_sources_view',
          args: AdminLessonSourcesRouteArgs(
            student: student,
            key: key,
          ),
        );

  static const String name = 'AdminLessonSourcesRoute';
}

class AdminLessonSourcesRouteArgs {
  const AdminLessonSourcesRouteArgs({
    this.student,
    this.key,
  });

  final Student? student;

  final Key? key;

  @override
  String toString() {
    return 'AdminLessonSourcesRouteArgs{student: $student, key: $key}';
  }
}
