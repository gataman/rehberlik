import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';
import '../../../../../models/lesson.dart';

part 'form_exam_state.dart';

class FormExamCubit extends Cubit<FormExamState> {
  FormExamCubit() : super(FormExamState());

  void checkExamResults({required Map<LessonCode, dynamic> examMap}) {
    if (_checkQuestionCount(examMap)) {
      debugPrint('Hata yok');
    } else {
      debugPrint('Hata var');
    }
  }

  bool _checkQuestionCount(Map<LessonCode, dynamic> examMap) {
    for (var lesson in examMap.keys) {
      final type = examMap[lesson]['type'] as LessonType;
      final dog = int.tryParse(examMap[lesson]['dog']);
      final yan = int.tryParse(examMap[lesson]['yan']);

      int maxCount = 20;
      if (type == LessonType.ten) {
        maxCount = 10;
      }

      if (dog != null && yan != null) {
        if (dog + yan > maxCount) {
          _showErrorState(message: '${lesson.name} dersi doğru ve yanlış sayılarını kontrol edin!');
          return false;
        }
      } else {
        _showErrorState(message: '${lesson.name} dersi doğru ve yanlış sayılarında sayısal bir değer girmelisiniz!');

        return false;
      }
    }

    return true;
  }

  void _showErrorState({required String message}) {
    emit(FormExamState(errorMessage: message));
    Future.delayed(const Duration(seconds: 3), () {
      resetErrorState();
    });
  }

  void resetErrorState() {
    emit(FormExamState(errorMessage: null, isSuccess: false));
  }
}
