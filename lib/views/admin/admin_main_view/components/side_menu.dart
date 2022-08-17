part of admin_main_view;

class SideMenu extends GetView<AdminMainViewController> {
  const SideMenu({Key? key}) : super(key: key);

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
                  Get.toNamed(Constants.routeDashboard, id: 1);

                  itemClicked();
                },
              ),
              DrawerListTile(
                title: "Sınıflar",
                iconSrc: "${iconsSrc}menu_classroom.svg",
                onPress: () {
                  Get.toNamed(Constants.routeClasses, id: 1);
                  itemClicked();
                },
              ),
              DrawerListTile(
                title: "Öğrenciler",
                iconSrc: "${iconsSrc}menu_classroom.svg",
                onPress: () {
                  Get.toNamed(Constants.routeStudents, id: 1);
                  itemClicked();
                },
              ),
              DrawerListTile(
                title: "Dersler",
                iconSrc: "${iconsSrc}menu_lesson.svg",
                onPress: () {
                  Get.toNamed(Constants.routeLessons, id: 1);
                  itemClicked();
                },
              ),
              /*
              DrawerListTile(
                title: "Çalışma Programı",
                iconSrc: "${iconsSrc}menu_timetable.svg",
                onPress: () {
                  Get.toNamed(Constants.routeStudyProgram, id: 1);
                  itemClicked();
                },
              ),

               */

              DrawerListTile(
                title: "Denemeler",
                iconSrc: "${iconsSrc}menu_meeting.svg",
                onPress: () {
                  Get.toNamed(Constants.routeTrialExams, id: 1);
                  itemClicked();
                },
              ),
              DrawerListTile(
                title: "Randevular",
                iconSrc: "${iconsSrc}menu_meeting.svg",
                onPress: () {
                  itemClicked();
                },
              ),
              DrawerListTile(
                title: "Mesajlar",
                iconSrc: "${iconsSrc}menu_mail.svg",
                onPress: () {
                  Get.toNamed(Constants.routeMessages, id: 1);
                  itemClicked();
                },
              ),
              DrawerListTile(
                title: "Yüklemeler",
                iconSrc: "${iconsSrc}menu_mail.svg",
                onPress: () {
                  Get.toNamed(Constants.routeUploads, id: 1);
                  itemClicked();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void itemClicked() {
    if (controller.scaffoldStateKey.currentState!.isDrawerOpen) {
      controller.scaffoldStateKey.currentState!.openEndDrawer();
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
