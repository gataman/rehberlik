import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/admin_classes/components/classes_select_box.dart';
import 'package:rehberlik/views/admin/admin_classes/components/student_list_box.dart';

class AdminStudentsView extends StatelessWidget {
  const AdminStudentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context) ? _mobileContent() : _desktopContent();
  }

  Widget _desktopContent() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: StudentListBox(),
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          Expanded(
            flex: 2,
            child: ClassesSelectBox(),
          ),
        ],
      ),
    );
  }

  Widget _mobileContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClassesSelectBox(),
          const SizedBox(
            height: defaultPadding,
          ),
          StudentListBox(),
        ],
      ),
    );
  }
}
