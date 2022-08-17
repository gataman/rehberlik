library admin_lessons_view;

import 'admin_lessons_imports.dart';

part 'components/lesson_list_box.dart';
part 'components/lesson_add_form_box.dart';

class AdminLessonsView extends AdminBaseView<AdminLessonsController> {
  const AdminLessonsView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const LessonListBox();

  @override
  Widget get secondView => const LessonAddFormBox();
}
