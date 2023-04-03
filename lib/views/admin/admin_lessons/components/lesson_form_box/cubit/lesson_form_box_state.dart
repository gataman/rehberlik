part of 'lesson_form_box_cubit.dart';

@immutable
abstract class LessonFormBoxState {}

class EditLessonState extends LessonFormBoxState {
  final Lesson? editLesson;

  EditLessonState({this.editLesson});
}
