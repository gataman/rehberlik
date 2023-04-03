import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../navigaton/app_router/app_routes.dart';
import 'profile_card.dart';

class StudentAppBar extends AppBar {
  StudentAppBar({Key? key}) : super(key: key);

  @override
  Widget? get title => const _StudentAppBarTitle();
}

class _StudentAppBarTitle extends StatelessWidget {
  const _StudentAppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (context.router.currentPath != AppRoutes.routeStudentDashboard) {
                context.router.replaceNamed(AppRoutes.routeStudentDashboard);
              }
            },
            child: Column(
              children: const [
                Text(
                  "Rehberlik Servisi",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
                Text(
                  "Öğrenci Paneli",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        /*
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

         */
        const ProfileCard()
      ],
    );
  }
}
