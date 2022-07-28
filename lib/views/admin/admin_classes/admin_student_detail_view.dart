import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';
import 'package:rehberlik/views/admin/admin_classes/components/student_detail_tab_view.dart';
import 'package:rehberlik/views/admin/admin_classes/components/student_info_card.dart';

class AdminStudentDetailView extends StatelessWidget {
  const AdminStudentDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context) ? _mobileContent() : _desktopContent();
  }

  Widget _desktopContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              //StudentInfoCard(),
              StudentDetailTabView(),
            ],
          ),
        ),
        const SizedBox(
          width: defaultPadding,
        ),
        Expanded(
          flex: 2,
          child: StudentInfoCard(),
        ),
      ],
    );
  }

  Widget _mobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Menü"),
        const SizedBox(
          height: defaultPadding,
        ),
        Column(
          children: const [
            Text("Öğrenci kimlik bilgileri kart"),
            Text("Diğer"),
          ],
        ),
      ],
    );
  }
}
