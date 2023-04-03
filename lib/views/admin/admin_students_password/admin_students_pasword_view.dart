import 'package:flutter/material.dart';
import '../admin_students/components/student_form_box/student_form_box.dart';
import 'student_password_list_card/student_password_list_card.dart';

import '../admin_base/admin_base_view.dart';

class AdminStudentsPasswordView extends AdminBaseView {
  const AdminStudentsPasswordView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const StudentPasswordListCard();

  @override
  Widget get secondView => StudentFormBox(
        hasPasswordMenu: true,
      );
}
