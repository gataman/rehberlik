import 'admin_routes.dart';

class AdminDrawerModel {
  String title;
  late String iconSrc;
  String route;

  AdminDrawerModel({required this.title, required String iconSrc, required this.route}) {
    this.iconSrc = "assets/icons/$iconSrc";
  }

  static final getAdminDrawerList = [
    AdminDrawerModel(title: "Ana Sayfa", iconSrc: 'menu_dashboard.svg', route: AdminRoutes.routeDashboard),
    AdminDrawerModel(title: "Sınıflar", iconSrc: 'menu_classroom.svg', route: AdminRoutes.routeClasses),
    AdminDrawerModel(title: "Öğrenciler", iconSrc: 'menu_classroom.svg', route: AdminRoutes.routeStudents),
    AdminDrawerModel(title: "Dersler", iconSrc: 'menu_lesson.svg', route: AdminRoutes.routeLessons),
    AdminDrawerModel(title: "Denemeler", iconSrc: 'menu_meeting.svg', route: AdminRoutes.routeTrialExams),
    AdminDrawerModel(title: "Randevular", iconSrc: 'menu_meeting.svg', route: AdminRoutes.routeTrialExams),
    AdminDrawerModel(title: "Mesajlar", iconSrc: 'menu_mail.svg', route: AdminRoutes.routeMessages),
    AdminDrawerModel(title: "Yüklemeler", iconSrc: 'menu_mail.svg', route: AdminRoutes.routeUploads),
  ];
}
