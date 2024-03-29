import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../models/subject.dart';

part 'edit_subject_state.dart';

class EditSubjectCubit extends Cubit<EditSubjectState> {
  EditSubjectCubit() : super(EditSubjectInitial(null));

  void editSubject(Subject? subject) {
    emit(EditSubjectInitial(subject));
  }
}
