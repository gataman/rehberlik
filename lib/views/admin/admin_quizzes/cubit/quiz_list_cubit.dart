import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/models/quiz.dart';
import 'package:rehberlik/repository/quiz_repository.dart';

import '../../../../common/locator.dart';

part 'quiz_list_state.dart';

class QuizListCubit extends Cubit<QuizListState> {
  QuizListCubit() : super(QuizListLoadingState());

  final _quizRepository = locator<QuizRepository>();
  Quiz? editedQuiz;
  List<Quiz> quizList = [];

  void fetchTrialExamList() async {
    final remoteList = await _quizRepository.getAll();
    if (remoteList != null) {
      quizList = remoteList;
    }

    _refreshList();
  }

  void editQuiz({required quiz}) {
    editedQuiz = quiz;
  }

  Future<String> addQuiz(Quiz quiz) async {
    final quizID = await _quizRepository.add(object: quiz);
    quiz.id = quizID;
    _addQuizInLocalList(quiz);

    return quizID;
  }

  void _addQuizInLocalList(Quiz quiz) {
    quizList.add(quiz);
    _refreshList();
  }

  void _refreshList() {
    debugPrint(quizList.toString());
    emit(QuizListLoadedState(quizList: quizList));
  }

  deleteQuiz({required Quiz quiz}) {}
}
