part of 'time_table_list_cubit.dart';

class TimeTableListState {
  final bool isLoading;
  final Map<int, List<TimeTable>>? timeTableList;
  final List<LessonWithSubject>? lessonWithSubjectList;

  TimeTableListState({this.isLoading = true, this.timeTableList, this.lessonWithSubjectList});
}
