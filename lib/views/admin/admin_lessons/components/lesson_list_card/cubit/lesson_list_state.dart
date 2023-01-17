part of 'lesson_list_cubit.dart';

class LessonListState {
  final bool isLoading;
  final int selectedCategory;
  final Map<int, List<LessonWithSubject>>? lessonList;

  LessonListState({required this.selectedCategory, this.lessonList, this.isLoading = true});
}
