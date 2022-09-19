import '../app_routes.dart';

class StudentDrawerModel {
  String title;
  late String iconSrc;
  String route;

  StudentDrawerModel({required this.title, required String iconSrc, required this.route}) {
    this.iconSrc = "assets/icons/$iconSrc";
  }

  static final getStudentDrawerList = [
    StudentDrawerModel(title: "Ana Sayfa", iconSrc: 'menu_dashboard.svg', route: AppRoutes.routeStudentDashboard),
  ];
}
