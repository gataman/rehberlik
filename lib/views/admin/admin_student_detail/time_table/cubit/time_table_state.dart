part of 'time_table_cubit.dart';

class TimeTableState {
  final bool isLoading;
  final Map<int, List<TimeTable>>? timeTableList;

  TimeTableState({this.isLoading = true, this.timeTableList});
}
