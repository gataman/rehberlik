import 'package:auto_route/auto_route.dart';

import '../admin_routes.dart';

class ArgumentsGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.args != null) {
      resolver.next(true);
    } else {
      var refreshRoute = AdminRoutes.routeDashboard;
      switch (resolver.route.path) {
        case AdminRoutes.routeStudentDetail:
          refreshRoute = AdminRoutes.routeStudents;
          break;

        case AdminRoutes.routeSubjects:
          refreshRoute = AdminRoutes.routeLessons;
          break;

        case AdminRoutes.routeTrialExamResult:
          refreshRoute = AdminRoutes.routeTrialExams;
          break;
      }

      router.navigateNamed(refreshRoute);
    }
  }
}
