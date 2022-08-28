library admin_subjects_view;

import 'package:rehberlik/common/navigaton/admin_routes.dart';

import 'admin_subjects_imports.dart';

part 'components/subject_list_box.dart';

part 'components/subject_add_form_box.dart';

class AdminSubjectsView extends AdminBaseView<AdminSubjectsController> {
  const AdminSubjectsView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const SubjectListBox();

  @override
  Widget get secondView => const SubjectAddFormBox();

  @override
  bool get isBack => true;
}
