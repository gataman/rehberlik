import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/init/locale_manager.dart';
import '../../../../core/init/pref_keys.dart';
import '../app_routes.dart';

class TeacherAuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_checkUser()) {
      if (resolver.route.path == AppRoutes.routeMainAuth) {
        router.replaceNamed(AppRoutes.routeMainAdmin);
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
    debugPrint('Chek User ${FirebaseAuth.instance.currentUser.toString()}');

    if (userID != null && userType != null && userType == 1) {
      return true;
    } else {
      if (FirebaseAuth.instance.currentUser != null) {
        return true;
      } else {
        return false;
      }
    }
  }
}
