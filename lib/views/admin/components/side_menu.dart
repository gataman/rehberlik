import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/admin_view_controller.dart';
import 'package:rehberlik/views/admin/dashboard/admin_dashboard_view.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);

  final _controller = Get.put(AdminViewController());

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
              DrawerListTile(
                title: "Ana Sayfa",
                iconSrc: "${iconsSrc}menu_dashboard.svg",
                onPress: () {
                  itemClicked(context, 0);
                },
              ),
              DrawerListTile(
                title: "Sınıflar",
                iconSrc: "${iconsSrc}menu_classroom.svg",
                onPress: () {
                  itemClicked(context, 1);
                },
              ),
              DrawerListTile(
                title: "Öğrenciler",
                iconSrc: "${iconsSrc}menu_classroom.svg",
                onPress: () {
                  itemClicked(context, 2);
                },
              ),
              DrawerListTile(
                title: "Dersler",
                iconSrc: "${iconsSrc}menu_lesson.svg",
                onPress: () {
                  itemClicked(context, 3);
                },
              ),
              DrawerListTile(
                title: "Çalışma Programı",
                iconSrc: "${iconsSrc}menu_timetable.svg",
                onPress: () {
                  itemClicked(context, 4);
                },
              ),
              DrawerListTile(
                title: "Randevular",
                iconSrc: "${iconsSrc}menu_meeting.svg",
                onPress: () {
                  itemClicked(context, 5);
                },
              ),
              DrawerListTile(
                title: "Mesajlar",
                iconSrc: "${iconsSrc}menu_mail.svg",
                onPress: () {
                  itemClicked(context, 6);
                },
              ),
              DrawerListTile(
                title: "Yüklemeler",
                iconSrc: "${iconsSrc}menu_mail.svg",
                onPress: () {
                  itemClicked(context, 7);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void itemClicked(BuildContext context, int pos) {
    _controller.selectMenuItem(pos);
    if (_controller.scaffoldStateKey.currentState!.isDrawerOpen) {
      _controller.scaffoldStateKey.currentState!.openEndDrawer();
    }
  }
}

class DrawerListTile extends StatelessWidget {
  final String title;
  final String iconSrc;
  final VoidCallback onPress;

  const DrawerListTile(
      {Key? key,
      required this.title,
      required this.iconSrc,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.0,
      onTap: onPress,
      leading: SvgPicture.asset(
        iconSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54, fontSize: 16),
      ),
    );
  }
}
