part of 'upload_tc_cubit.dart';

@immutable
abstract class UploadTcState {}

class UploadExcelDefaultState extends UploadTcState {}

class UploadTcParsedState extends UploadTcState {
  final bool isLoading;
  final List<Student>? parsedStudentList;

  UploadTcParsedState({required this.isLoading, this.parsedStudentList});
}

class UploadTcSavedState extends UploadTcState {
  final bool isLoading;
  final bool hasError;

  UploadTcSavedState({this.isLoading = true, this.hasError = false});
}
