import '../app_routes.dart';

class TeacherDrawerModel {
  String title;
  late String iconSrc;
  String route;

  TeacherDrawerModel({required this.title, required String iconSrc, required this.route}) {
    this.iconSrc = "assets/icons/$iconSrc";
  }

  static final getTeacherDrawerList = [
    TeacherDrawerModel(
        title: "Deneme Sınavları", iconSrc: 'menu_trial_exam.svg', route: AppRoutes.routeAdminTrialExams),
    TeacherDrawerModel(title: "Sınıflar", iconSrc: 'menu_classroom.svg', route: AppRoutes.routeAdminClasses),
    TeacherDrawerModel(title: "Öğrenciler", iconSrc: 'menu_classroom.svg', route: AppRoutes.routeAdminStudents),
    TeacherDrawerModel(
        title: "Deneme İstatistikleri",
        iconSrc: 'menu_statics.svg',
        route: AppRoutes.routeAdminStudentsTrialExamDetailView),
    TeacherDrawerModel(
        title: "Şifre İşlemleri", iconSrc: 'menu_schedule.svg', route: AppRoutes.routeAdminStudentsPassword),
  ];
}
