abstract class AppRoutes {
  //* MainRoutes
  static const String routeMainAdmin = "/admin";
  static const String routeMainSplash = "/splash";
  static const String routeMainAuth = "/auth";
  static const String routeMainStudent = "/student";

  //* Admin Routes
  static const String routeAdminDashboard = "dashboard";
  static const String routeAdminClasses = "classes";
  static const String routeAdminStudents = "students";
  static const String routeAdminStudentDetail = "student_detail";
  static const String routeAdminLessons = "lessons";
  static const String routeAdminQuestionFollow = "questionFollow";
  static const String routeAdminSubjects = "subjects";
  //static const String routeSubjects = "/subject/:lessonID";
  static const String routeAdminMessages = "messages";
  static const String routeAdminUploads = "uploads";
  static const String routeAdminTrialExams = "trial_exams";
  static const String routeAdminTrialExamResult = "trial_exam_result";
  static const String routeAdminTrialExamTotal = "trial_exam_total_average";
  static const String routeAdminTrialExamResultClassStatics = "trial_exam_result_class_statics";
  static const String routeAdminTrialExamExcelImport = "trial_exam_result_exam_import";
  static const String routeAdminStudentsPassword = "students_password";
  static const String routeAdminStudentsTrialExamDetailView = "students_trial_exam_detail";
  static const String routeAdminQuizzes = "admin_quizzes";

  //* Student Routes
  static const String routeStudentDashboard = "dashboard";
  static const String routeStudentQuestionFollow = "soru_takibi";
  static const String routeStudentTrialExam = "deneme_sinavlari";
}
