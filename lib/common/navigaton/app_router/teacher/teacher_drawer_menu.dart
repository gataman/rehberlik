import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'teacher_drawer_model.dart';
import '../../../constants.dart';
import '../../admin_drawer_list_tile.dart';
import '../app_router.dart';
import '../app_routes.dart';

class TeacherDrawerMenu extends StatelessWidget {
  const TeacherDrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width < 500 ? width * 0.7 : null,
      child: Drawer(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Image.asset("${imagesSrc}logo.png")),
                    Text(
                      'Başarı İzleme Uygulaması',
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
              for (var listItem in TeacherDrawerModel.getTeacherDrawerList)
                AdminDrawerListTile(
                  title: listItem.title,
                  iconSrc: listItem.iconSrc,
                  tileColor: context.router.currentPath == '/teacher/${listItem.route}' ? Colors.white12 : null,
                  onPress: () {
                    Navigator.pop(context);
                    if (listItem.route == AppRoutes.routeAdminStudentsTrialExamDetailView) {
                      context.router.replace(AdminStudentsTrialExamDetailRoute(student: null));
                    } else {
                      context.router.replaceNamed(listItem.route);
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void itemClicked() {
    /*
    if (controller.scaffoldStateKey.currentState!.isDrawerOpen) {
      controller.scaffoldStateKey.currentState!.openEndDrawer();
    }

     */
  }
}
