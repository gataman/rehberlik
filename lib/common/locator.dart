import 'package:get_it/get_it.dart';
import 'package:rehberlik/repository/auth_repository.dart';
import 'package:rehberlik/services/auth_service.dart';

import '../repository/classes_repository.dart';
import '../repository/lesson_repository.dart';
import '../repository/meeting_repository.dart';
import '../repository/school_repository.dart';
import '../repository/student_repository.dart';
import '../repository/study_program_repository.dart';
import '../repository/subject_repository.dart';
import '../repository/time_table_repository.dart';
import '../repository/trial_exam_repository.dart';
import '../repository/trial_exam_result_repository.dart';
import '../services/classes_service.dart';
import '../services/lesson_service.dart';
import '../services/meeting_service.dart';
import '../services/schools_service.dart';
import '../services/student_service.dart';
import '../services/study_program_service.dart';
import '../services/subject_service.dart';
import '../services/time_table_service.dart';
import '../services/trial_exam_result_service.dart';
import '../services/trial_exam_service.dart';

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

  //StudyProgram:
  locator.registerLazySingleton(() => StudyProgramService());
  locator.registerLazySingleton(() => StudyProgramRepository());

  //AuthServie
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthRepository());
}
