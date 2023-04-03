part of 'class_form_box_cubit.dart';

@immutable
abstract class ClassFormBoxState {}

class EditClassState extends ClassFormBoxState {
  final Classes? editedClass;

  EditClassState(this.editedClass);
}
