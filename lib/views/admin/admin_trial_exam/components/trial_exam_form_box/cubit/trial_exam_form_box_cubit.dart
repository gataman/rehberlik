import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../models/trial_exam.dart';

part 'trial_exam_form_box_state.dart';

class TrialExamFormBoxCubit extends Cubit<TrialExamFormBoxState> {
  TrialExamFormBoxCubit() : super(EditTrialExamState(editTrialExam: null));

  void editTrialExam({TrialExam? trialExam}) {
    emit(EditTrialExamState(editTrialExam: trialExam));
  }
}
