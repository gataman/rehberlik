library admin_trial_exam_result_view;

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'admin_trial_exam_result_imports.dart';

part 'components/trial_exam_result_data_grid.dart';

class AdminTrialExamResultView
    extends AdminBaseView<AdminTrialExamResultController> {
  const AdminTrialExamResultView({Key? key}) : super(key: key);

  @override
  Widget get firstView => TrialExamResultDataGrid();

  @override
  Widget get secondView => const Text("ddd");
}