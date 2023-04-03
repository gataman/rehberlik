part of 'lesson_sources_cubit.dart';

@immutable
abstract class LessonSourcesState {}

class StudentLessonSourcesLoadingState extends LessonSourcesState {}

class StudentLessonSourcesSelectedStade extends LessonSourcesState {
  final Student student;
  final List<Map<String, dynamic>> mapList;

  StudentLessonSourcesSelectedStade({
    required this.student,
    required this.mapList,
  });
}
