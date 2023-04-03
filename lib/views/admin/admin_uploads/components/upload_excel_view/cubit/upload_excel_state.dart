part of 'upload_excel_cubit.dart';

@immutable
abstract class UploadExcelState {}

class UploadExcelDefaultState extends UploadExcelState {}

class UploadExcelParsedState extends UploadExcelState {
  final bool isLoading;
  final Map<String, List<Student>>? parsedStudentList;

  UploadExcelParsedState({required this.isLoading, this.parsedStudentList});
}

class UploadExcelSavedState extends UploadExcelState {
  final bool isLoading;
  final bool hasError;

  UploadExcelSavedState({this.isLoading = true, this.hasError = false});
}
