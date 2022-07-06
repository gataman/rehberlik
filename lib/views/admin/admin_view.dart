import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/admin_view_controller.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/components/side_menu.dart';
import 'package:rehberlik/views/admin/dashboard/components/footer.dart';
import 'package:rehberlik/views/admin/dashboard/components/header.dart';

class AdminView extends GetView<AdminViewController> {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldStateKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Left SideMenu
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Header(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (Responsive.isMobile(context))
                            const SizedBox(height: defaultPadding),
                          if (Responsive.isMobile(context)) const SearchField(),
                          Container(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Obx(() => controller.getSelectedView())),
                          // Orta Sayfa
                          const Footer()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
