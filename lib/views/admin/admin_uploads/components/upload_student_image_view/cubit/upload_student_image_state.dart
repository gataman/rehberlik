part of 'upload_student_image_cubit.dart';

@immutable
abstract class UploadStudentImageState {}

class UploadStudentImageDefaultState extends UploadStudentImageState {}

class UploadStudentImageLoadingState extends UploadStudentImageState {
  final bool isLoading;
  final int totalImageCount;
  final int loadedImageCount;

  UploadStudentImageLoadingState(
      {this.isLoading = true, this.totalImageCount = 0, this.loadedImageCount = 0});
}

class UploadStudentImageLoadedState extends UploadStudentImageState {
  final bool hasError;

  UploadStudentImageLoadedState({this.hasError = false});
}
