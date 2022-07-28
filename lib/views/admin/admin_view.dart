import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_view.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_student_detail_view.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_students_view.dart';
import 'package:rehberlik/views/admin/admin_lessons/admin_lessons_view.dart';
import 'package:rehberlik/views/admin/admin_study_program/admin_study_program_view.dart';
import 'package:rehberlik/views/admin/admin_view_controller.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/components/side_menu.dart';
import 'package:rehberlik/views/admin/dashboard/admin_dashboard_view.dart';
import 'package:rehberlik/views/admin/dashboard/components/header.dart';

class AdminView extends GetView<AdminViewController> {
  AdminView({Key? key}) : super(key: key);
  final _navigatorKey = Get.nestedKey(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldStateKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          children: [
            //Left SideMenu
            if (Responsive.isDesktop(context)) Expanded(child: SideMenu()),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Header(),
                  if (Responsive.isMobile(context))
                    const SizedBox(height: defaultPadding),
                  if (Responsive.isMobile(context)) const SearchField(),
                  Expanded(
                    child: _getNavigator(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getNavigator() {
    var pageRoute = GetPageRoute(
      page: () => AdminDashboardView(),
    );
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 550,
      child: WillPopScope(
        onWillPop: () async {
          return !await didPopRoute();
        },
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (settings) {
            debugPrint("Settings Name ${settings.name!}");
            if (settings.name != null) {
              switch (settings.name!) {
                case Constants.routeDashboard:
                  pageRoute = GetPageRoute(
                    page: () => AdminDashboardView(),
                  );
                  break;
                case Constants.routeClasses:
                  pageRoute = GetPageRoute(
                    page: () => const AdminClassesView(),
                  );
                  break;
                case Constants.routeStudents:
                  pageRoute = GetPageRoute(
                    page: () => const AdminStudentsView(),
                  );
                  break;
                case Constants.routeStudentDetail:
                  pageRoute = GetPageRoute(
                    page: () => const AdminStudentDetailView(),
                  );
                  break;
                case Constants.routeLessons:
                  pageRoute = GetPageRoute(
                    page: () => const AdminLessonsView(),
                  );
                  break;
                case Constants.routeStudyProgram:
                  pageRoute = GetPageRoute(
                    page: () => AdminStudyProgramView(),
                  );
                  break;
                case '/':
                  pageRoute = GetPageRoute(
                    page: () => AdminDashboardView(),
                  );
                  break;
              }
            }
            return pageRoute;
          },
        ),
      ),
    );
  }

  Future<bool> didPopRoute() async {
    final NavigatorState? navigator = _navigatorKey!.currentState;
    assert(navigator != null);
    return await navigator!.maybePop();
  }
}
