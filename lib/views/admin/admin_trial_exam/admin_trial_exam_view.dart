library admin_trial_exam_view;

import 'admin_trial_exam_imports.dart';

part 'components/trial_exam_list_box.dart';
part 'components/trial_exam_add_form_box.dart';

class AdminTrialExamView extends AdminBaseView<AdminTrialExamController> {
  const AdminTrialExamView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const TrialExamListBox();

  @override
  Widget get secondView => const TrialExamAddFormBox();
}
