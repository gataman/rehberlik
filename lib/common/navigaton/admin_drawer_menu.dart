import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/navigaton/admin_drawer_list_tile.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/navigaton/admin_drawer_model.dart';

class AdminDrawerMenu extends StatelessWidget {
  const AdminDrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: _width < 500 ? _width * 0.7 : null,
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
                  tileColor: Get.currentRoute == listItem.route
                      ? Colors.white12
                      : null,
                  onPress: () {
                    Get.offNamed(listItem.route);
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
