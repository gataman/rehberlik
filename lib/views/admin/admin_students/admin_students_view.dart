import 'package:flutter/material.dart';
import '../admin_base/admin_base_view.dart';

import 'components/student_form_box/student_form_box.dart';
import 'components/student_list_card/student_list_card.dart';

class AdminStudentsView extends AdminBaseView {
  const AdminStudentsView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const StudentListBox();

  @override
  Widget get secondView => StudentFormBox(
        hasPasswordMenu: false,
      );
}
