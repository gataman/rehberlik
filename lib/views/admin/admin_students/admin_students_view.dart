library admin_students_view;

import 'admin_students_imports.dart';

part 'student_list_box.dart';
part 'classes_select_box.dart';

class AdminStudentsView extends AdminBaseView<AdminStudentsController> {
  const AdminStudentsView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const StudentListBox();

  @override
  Widget get secondView => const ClassesSelectBox();
}
