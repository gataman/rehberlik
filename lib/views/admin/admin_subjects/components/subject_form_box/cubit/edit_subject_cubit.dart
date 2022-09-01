import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rehberlik/models/subject.dart';

part 'edit_subject_state.dart';

class EditSubjectCubit extends Cubit<EditSubjectState> {
  EditSubjectCubit() : super(EditSubjectInitial(null));

  void editSubject(Subject? subject) {
    emit(EditSubjectInitial(subject));
  }
}
