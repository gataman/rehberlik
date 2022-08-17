library admin_classes_view;

import 'admin_classes_imports.dart';

part 'components/class_list_box.dart';
part 'components/classes_add_form_box.dart';
part 'components/classes_category_select_box.dart';

class AdminClassesView extends AdminBaseView<AdminClassesController> {
  const AdminClassesView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const ClassListBox();

  @override
  Widget get secondView => const ClassesAddFormBox();
}
