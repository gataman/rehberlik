import '../app_routes.dart';

class StudentDrawerModel {
  String title;
  late String iconSrc;
  String route;

  StudentDrawerModel({required this.title, required String iconSrc, required this.route}) {
    this.iconSrc = "assets/icons/$iconSrc";
  }

  static final getStudentDrawerList = [
    StudentDrawerModel(
        title: "Deneme Sınavı Sonuç Karnesi", iconSrc: 'menu_timetable.svg', route: AppRoutes.routeStudentTrialExam),
    StudentDrawerModel(
        title: "Deneme Sınavları", iconSrc: 'menu_timetable.svg', route: AppRoutes.routeStudentTrialExamList),
    StudentDrawerModel(
        title: "Çalışma Programı", iconSrc: 'menu_dashboard.svg', route: AppRoutes.routeStudentDashboard),
    StudentDrawerModel(
        title: "Soru Takip Çizelgesi", iconSrc: 'menu_timetable.svg', route: AppRoutes.routeStudentQuestionFollow),
  ];
}
