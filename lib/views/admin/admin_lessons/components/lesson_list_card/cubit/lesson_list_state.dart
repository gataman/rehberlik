part of 'lesson_list_cubit.dart';

class LessonListState {
  final bool isLoading;
  final int selectedCategory;
  final List<Lesson>? lessonList;

  LessonListState(
      {required this.selectedCategory, this.lessonList, this.isLoading = true});
}
