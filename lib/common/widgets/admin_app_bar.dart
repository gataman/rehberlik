import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/navigaton/admin_routes.dart';
import 'package:rehberlik/common/widgets/profile_card.dart';
import 'package:rehberlik/common/widgets/search_widget.dart';

class AdminAppBar extends AppBar {
  @override
  Widget? get title => const _AdminAppBarTitle();
}

class _AdminAppBarTitle extends StatelessWidget {
  const _AdminAppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (Get.currentRoute != AdminRoutes.routeDashboard) {
                Get.toNamed(AdminRoutes.routeDashboard);
              }
            },
            child: Column(
              children: const [
                Text(
                  "Rehberlik Servisi",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
                Text(
                  "Yönetici Paneli",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          child: SearchWidget(
              text: 'Öğrenci Arama',
              onChanged: (text) {
                if (text.length > 2) {
                  _showSearchDialog(text, context).then((value) {
                    if (text.length < 2) {
                      Get.back();
                    }
                  });
                }
              },
              hintText: 'Öğrenci Arama'),
        ),
        const ProfileCard()
      ],
    );
  }

  Future<dynamic> _showSearchDialog(String text, BuildContext context) {
    final dialog = showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog();
        });

    return dialog;
  }
}
