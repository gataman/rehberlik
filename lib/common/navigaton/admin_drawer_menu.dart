import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'admin_drawer_list_tile.dart';
import 'admin_drawer_model.dart';
import 'app_router/app_router.dart';

class AdminDrawerMenu extends StatelessWidget {
  const AdminDrawerMenu({Key? key}) : super(key: key);

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
              for (var listItem in AdminDrawerModel.getAdminDrawerList)
                AdminDrawerListTile(
                  title: listItem.title,
                  iconSrc: listItem.iconSrc,
                  tileColor: context.router.currentPath == '/admin/${listItem.route}' ? Colors.white12 : null,
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
