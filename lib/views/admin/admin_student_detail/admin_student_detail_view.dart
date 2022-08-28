library admin_student_detail_view;

import 'admin_student_detail_imports.dart';

part 'components/student_detail_tab_view.dart';
part 'components/student_info_card.dart';

class AdminStudentDetailView
    extends AdminBaseView<AdminStudentDetailController> {
  const AdminStudentDetailView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const StudentDetailTabView();

  @override
  Widget get secondView => StudentInfoCard();

  @override
  bool get isBack => true;
}
