import 'package:get_it/get_it.dart';
import 'package:rehberlik/repository/classes_repository.dart';
import 'package:rehberlik/repository/lesson_repository.dart';
import 'package:rehberlik/repository/student_repository.dart';
import 'package:rehberlik/repository/study_program_repository.dart';
import 'package:rehberlik/repository/subject_repository.dart';
import 'package:rehberlik/repository/time_table_repository.dart';
import 'package:rehberlik/repository/trial_exam_repository.dart';
import 'package:rehberlik/services/classes_service.dart';
import 'package:rehberlik/services/lesson_service.dart';
import 'package:rehberlik/services/student_service.dart';
import 'package:rehberlik/services/study_program_service.dart';
import 'package:rehberlik/services/subject_service.dart';
import 'package:rehberlik/services/time_table_service.dart';
import 'package:rehberlik/services/trial_exam_service.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'package:rehberlik/views/admin/admin_students/components/student_list_card/cubit/student_list_cubit.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //Lessons
  locator.registerLazySingleton(() => LessonService());
  locator.registerLazySingleton(() => LessonRepository());

  //Subjects
  locator.registerLazySingleton(() => SubjectService());
  locator.registerLazySingleton(() => SubjectRepository());

  //TrialExam
  locator.registerLazySingleton(() => TrialExamService());
  locator.registerLazySingleton(() => TrialExamRepository());

  //Student
  locator.registerLazySingleton(() => StudentService());
  locator.registerLazySingleton(() => StudentRepository());

  //Classes
  locator.registerLazySingleton(() => ClassesService());
  locator.registerLazySingleton(() => ClassesRepository());

  //TimeTable:
  locator.registerLazySingleton(() => TimeTableService());
  locator.registerLazySingleton(() => TimeTableRepository());

  //Cubits:
  locator.registerLazySingleton(() => StudyProgramService());
  locator.registerLazySingleton(() => StudyProgramRepository());
}
