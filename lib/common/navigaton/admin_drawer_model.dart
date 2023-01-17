import 'app_router/app_routes.dart';

class AdminDrawerModel {
  String title;
  late String iconSrc;
  String route;

  AdminDrawerModel({required this.title, required String iconSrc, required this.route}) {
    this.iconSrc = "assets/icons/$iconSrc";
  }

  static final getAdminDrawerList = [
    AdminDrawerModel(title: "Ana Sayfa", iconSrc: 'menu_dashboard.svg', route: AppRoutes.routeAdminDashboard),
    AdminDrawerModel(title: "Sınıflar", iconSrc: 'menu_classroom.svg', route: AppRoutes.routeAdminClasses),
    AdminDrawerModel(title: "Öğrenciler", iconSrc: 'menu_classroom.svg', route: AppRoutes.routeAdminStudents),
    AdminDrawerModel(title: "Dersler", iconSrc: 'menu_lesson.svg', route: AppRoutes.routeAdminLessons),
    AdminDrawerModel(title: "Denemeler", iconSrc: 'menu_meeting.svg', route: AppRoutes.routeAdminTrialExams),
    AdminDrawerModel(
        title: "Deneme İstatistikleri",
        iconSrc: 'menu_meeting.svg',
        route: AppRoutes.routeAdminStudentsTrialExamDetailView),
    AdminDrawerModel(title: "Kaynak Takibi", iconSrc: 'menu_meeting.svg', route: AppRoutes.routeAdminLessonSourcesView),
    AdminDrawerModel(title: "Şifre İşlemleri", iconSrc: 'menu_lesson.svg', route: AppRoutes.routeAdminStudentsPassword),
    //AdminDrawerModel(title: "Mesajlar", iconSrc: 'menu_mail.svg', route: AppRoutes.routeAdminMessages),
    AdminDrawerModel(title: "Yüklemeler", iconSrc: 'menu_mail.svg', route: AppRoutes.routeAdminUploads),
    // AdminDrawerModel(title: "Bilgi Yarışması", iconSrc: 'menu_lesson.svg', route: AppRoutes.routeAdminQuizzes),
  ];
}
