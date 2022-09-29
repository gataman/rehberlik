import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/student.dart';

part 'student_trial_exam_detail_state.dart';

class StudentTrialExamDetailCubit extends Cubit<StudentTrialExamDetailState> {
  StudentTrialExamDetailCubit() : super(StudentTrialExamLoidingState());

  Student? selectedStudent;

  void selectStudent(Student student) {
    selectedStudent = student;
    emit(StudentTrialExamStudentSelectedStade(student: selectedStudent!));
  }
}
