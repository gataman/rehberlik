import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rehberlik/models/lesson.dart';

part 'lesson_form_box_state.dart';

class LessonFormBoxCubit extends Cubit<LessonFormBoxState> {
  LessonFormBoxCubit() : super(EditLessonState(editLesson: null));

  void editLesson({Lesson? lesson}) {
    emit(EditLessonState(editLesson: lesson));
  }
}
