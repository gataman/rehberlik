library admin_student_detail_view;

import 'package:rehberlik/views/admin/admin_base/admin_base_views.dart';

import 'admin_student_detail_imports.dart';

part 'components/student_detail_tab_view.dart';
part 'components/student_info_card.dart';

class AdminStudentDetailView extends AdminBaseViews {
  const AdminStudentDetailView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const StudentDetailTabView();

  @override
  Widget get secondView => StudentInfoCard();

  @override
  bool get isBack => true;

  @override
  String get refreshRoute => Constants.routeStudents;
}
