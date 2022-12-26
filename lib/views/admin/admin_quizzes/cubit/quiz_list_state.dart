part of 'quiz_list_cubit.dart';

@immutable
abstract class QuizListState {}

class QuizListLoadingState extends QuizListState {}

class QuizListLoadedState extends QuizListState {
  final List<Quiz>? quizList;

  QuizListLoadedState({required this.quizList});
}

class EditQuizState extends QuizListState {
  final Quiz editQuiz;

  EditQuizState({required this.editQuiz});
}
