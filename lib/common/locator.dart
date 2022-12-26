import 'package:get_it/get_it.dart';
import 'package:rehberlik/repository/auth_repository.dart';
import 'package:rehberlik/repository/quiz_repository.dart';
import 'package:rehberlik/repository/teacher_repository.dart';
import 'package:rehberlik/repository/trial_exam_class_result_repository.dart';
import 'package:rehberlik/services/auth_service.dart';
import 'package:rehberlik/services/quiz_service.dart';
import 'package:rehberlik/services/teacher_service.dart';
import 'package:rehberlik/services/trial_exam_class_result_service.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/helper/trial_exam_result_helper.dart';

import '../repository/classes_repository.dart';
import '../repository/lesson_repository.dart';
import '../repository/meeting_repository.dart';
import '../repository/school_repository.dart';
import '../repository/student_repository.dart';
import '../repository/question_follow_repository.dart';
import '../repository/subject_repository.dart';
import '../repository/time_table_repository.dart';
import '../repository/trial_exam_repository.dart';
import '../repository/trial_exam_result_repository.dart';
import '../repository/trial_exam_student_result_repository.dart';
import '../services/classes_service.dart';
import '../services/lesson_service.dart';
import '../services/meeting_service.dart';
import '../services/schools_service.dart';
import '../services/student_service.dart';
import '../services/question_follow_service.dart';
import '../services/subject_service.dart';
import '../services/time_table_service.dart';
import '../services/trial_exam_result_service.dart';
import '../services/trial_exam_service.dart';
import '../services/trial_exam_student_result_service.dart';
import '../views/admin/admin_trial_exam_detail/helper/trial_exam_student_result_helper.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //Schools:
  locator.registerLazySingleton(() => SchoolService());
  locator.registerLazySingleton(() => SchoolRepository());

  //Classes
  locator.registerLazySingleton(() => ClassesService());
  locator.registerLazySingleton(() => ClassesRepository());

  //Lessons
  locator.registerLazySingleton(() => LessonService());
  locator.registerLazySingleton(() => LessonRepository());

  //Student
  locator.registerLazySingleton(() => StudentService());
  locator.registerLazySingleton(() => StudentRepository());

  //Subjects
  locator.registerLazySingleton(() => SubjectService());
  locator.registerLazySingleton(() => SubjectRepository());

  //TrialExam
  locator.registerLazySingleton(() => TrialExamService());
  locator.registerLazySingleton(() => TrialExamRepository());

  //Meeting:
  locator.registerLazySingleton(() => TrialExamResultRepository());
  locator.registerLazySingleton(() => TrialExamResultService());

  //TimeTable:
  locator.registerLazySingleton(() => TimeTableService());
  locator.registerLazySingleton(() => TimeTableRepository());

  //Meeting:
  locator.registerLazySingleton(() => MeetingService());
  locator.registerLazySingleton(() => MeetingReposityory());

  //QuestionFollow:
  locator.registerLazySingleton(() => QuestionFollowService());
  locator.registerLazySingleton(() => QuestionFollowRepository());

  //AuthServie
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthRepository());

  //TeacherService
  locator.registerLazySingleton(() => TeacherService());
  locator.registerLazySingleton(() => TeacherRepository());

  //TrialExamClassResultService
  locator.registerLazySingleton(() => TrialExamClassResultService());
  locator.registerLazySingleton(() => TrialExamClassResultRepository());

  //TrialExamStudentResultService
  locator.registerLazySingleton(() => TrialExamStudentResultService());
  locator.registerLazySingleton(() => TrialExamStudentResultRepository());

  //Helper
  locator.registerLazySingleton(() => TrialExamResultHelper());
  locator.registerLazySingleton(() => TrialExamStudentResultHelper());

  //TrialExamStudentResultService
  locator.registerLazySingleton(() => QuizService());
  locator.registerLazySingleton(() => QuizRepository());
}
