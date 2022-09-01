part of 'edit_subject_cubit.dart';

@immutable
abstract class EditSubjectState {}

class EditSubjectInitial extends EditSubjectState {
  final Subject? editSubject;

  EditSubjectInitial(this.editSubject);
}
