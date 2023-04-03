import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../models/lesson.dart';

part 'lesson_form_box_state.dart';

class LessonFormBoxCubit extends Cubit<LessonFormBoxState> {
  LessonFormBoxCubit() : super(EditLessonState(editLesson: null));

  void editLesson({Lesson? lesson}) {
    emit(EditLessonState(editLesson: lesson));
  }
}
