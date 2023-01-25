import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:rehberlik/common/enums/user_type.dart';

import '../../../../core/init/locale_manager.dart';
import '../../../../core/init/pref_keys.dart';
import '../../../../models/teacher.dart';
import '../app_routes.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final userID = SharedPrefs.instance.getString(PrefKeys.userID.toString());
    final userType = SharedPrefs.instance.getInt(PrefKeys.userType.toString());
    final student = SharedPrefs.instance.getString(PrefKeys.student.toString());
    final teacher = SharedPrefs.instance.getString(PrefKeys.teacher.toString());

    if (userID != null && userType != null) {
      if (resolver.route.path == AppRoutes.routeMainAuth) {
        if (userType == UserType.teacher.type && teacher != null) {
          if (_getTeacherType(teacher) == TeacherType.admin) {
            router.replaceNamed(AppRoutes.routeMainAdmin);
          } else {
            router.replaceNamed(AppRoutes.routeMainTeacher);
          }
        } else if (userType == UserType.student.type && student != null) {
          router.replaceNamed(AppRoutes.routeMainStudent);
        } else {
          resolver.next(true);
        }
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

  TeacherType _getTeacherType(String? teacher) {
    if (teacher != null) {
      final decodedTeacher = Teacher.fromJson(jsonDecode(teacher)!);
      if (decodedTeacher.rank == TeacherType.admin.type) {
        return TeacherType.admin;
      }
    }

    return TeacherType.teacher;
  }
}
