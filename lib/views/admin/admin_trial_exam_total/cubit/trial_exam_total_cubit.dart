import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trial_exam_total_state.dart';

class TrialExamTotalCubit extends Cubit<TrialExamTotalState> {
  TrialExamTotalCubit() : super(TrialExamTotalInitial());
}
