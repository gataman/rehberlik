part of 'class_list_cubit.dart';

class ClassListState {
  final bool isLoading;
  final List<StudentWithClass>? studentWithClassList;

  ClassListState({this.studentWithClassList, this.isLoading = true});
}
