import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/navigaton/app_router/student/student_drawer_list_tile.dart';
import 'package:rehberlik/common/navigaton/app_router/student/student_drawer_model.dart';

import '../../../constants.dart';

class StudentDrawerMenu extends StatelessWidget {
  const StudentDrawerMenu({Key? key}) : super(key: key);

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
              DrawerHeader(child: Image.asset("${imagesSrc}logo.png")),
              for (var listItem in StudentDrawerModel.getStudentDrawerList)
                StudentDrawerListTile(
                  title: listItem.title,
                  iconSrc: listItem.iconSrc,
                  tileColor: context.router.currentPath == '/student/${listItem.route}' ? Colors.white12 : null,
                  onPress: () {
                    Navigator.pop(context);
                    context.router.replaceNamed(listItem.route);
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