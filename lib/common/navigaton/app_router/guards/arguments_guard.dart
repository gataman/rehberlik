import 'package:auto_route/auto_route.dart';

import '../app_routes.dart';

class ArgumentsGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.args != null) {
      resolver.next(true);
    } else {
      var refreshRoute = AppRoutes.routeAdminDashboard;
      switch (resolver.route.path) {
        case AppRoutes.routeAdminStudentDetail:
          refreshRoute = AppRoutes.routeAdminStudents;
          break;

        case AppRoutes.routeAdminSubjects:
          refreshRoute = AppRoutes.routeAdminLessons;
          break;

        case AppRoutes.routeAdminTrialExamResult:
          refreshRoute = AppRoutes.routeAdminTrialExams;
          break;
      }

      router.navigateNamed(refreshRoute);
    }
  }
}
