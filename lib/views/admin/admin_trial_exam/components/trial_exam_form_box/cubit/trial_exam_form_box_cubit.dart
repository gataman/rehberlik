import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../models/trial_exam.dart';

part 'trial_exam_form_box_state.dart';

class TrialExamFormBoxCubit extends Cubit<TrialExamFormBoxState> {
  TrialExamFormBoxCubit() : super(EditTrialExamState(editTrialExam: null));

  void editTrialExam({TrialExam? trialExam}) {
    debugPrint('editTrialExam');
    emit(EditTrialExamState(editTrialExam: trialExam));
  }
}
