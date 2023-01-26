import 'package:auto_route/auto_route.dart';
import 'package:rehberlik/common/enums/user_type.dart';

import '../../../../core/init/locale_manager.dart';
import '../../../../core/init/pref_keys.dart';
import '../app_routes.dart';

class StudentAuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_checkUser()) {
      if (resolver.route.path == AppRoutes.routeMainAuth) {
        router.replaceNamed(AppRoutes.routeMainStudent);
      } else {
        resolver.next(true);
      }
    } else {
      if (resolver.route.path == AppRoutes.routeMainAuth) {
        resolver.next(true);
      } else {
        router.replaceNamed(AppRoutes.routeMainAuth);
      }
    }
  }

  bool _checkUser() {
    final userID = SharedPrefs.instance.getString(PrefKeys.userID.toString());
    final userType = SharedPrefs.instance.getInt(PrefKeys.userType.toString());
    final student = SharedPrefs.instance.getString(PrefKeys.student.toString());

    if (userID != null && userType != null && userType == UserType.student.type && student != null) {
      return true;
    } else {
      return false;
    }
  }
}
