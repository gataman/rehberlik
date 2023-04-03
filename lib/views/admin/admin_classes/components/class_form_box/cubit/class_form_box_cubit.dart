import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../models/classes.dart';

part 'class_form_box_state.dart';

class ClassFormBoxCubit extends Cubit<ClassFormBoxState> {
  ClassFormBoxCubit() : super(EditClassState(null));

  void editClass({Classes? classes}) {
    emit(EditClassState(classes));
  }
}
