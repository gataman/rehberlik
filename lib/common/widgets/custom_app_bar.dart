import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/core/widgets/popup_menu/custom_popup_menu_button.dart';

import '../../core/init/locale_manager.dart';
import '../../core/init/pref_keys.dart';
import '../../models/student.dart';
import '../../models/teacher.dart';
import '../../views/app_main/cubit/app_main_cubit.dart';
import '../constants.dart';
import '../navigaton/app_router/app_routes.dart';

class CustomAppBar extends AppBar {
  final BuildContext context;
  final bool isStudent;

  CustomAppBar({required this.context, this.isStudent = false, Key? key}) : super(key: key);

  @override
  Widget? get title => _AdminAppBarTitle(
        isStudent: isStudent,
      );

  @override
  List<Widget>? get actions => [
        CustomPopupMenuButton(menuList: [
          CustomPopupMenuButton.createMenuItem(
            context: context,
            iconData: CupertinoIcons.person,
            title: 'Kullanıcı Bilgileri',
          ),
          CustomPopupMenuButton.createMenuItem(
              context: context,
              iconData: Icons.change_circle,
              title: 'Temayı Değiştir',
              onTap: () => context.read<AppMainCubit>().changeTheme()),
          CustomPopupMenuButton.createMenuItem(
            context: context,
            iconData: Icons.settings,
            title: 'Ayarlar',
          ),
          const PopupMenuDivider(),
          CustomPopupMenuButton.createMenuItem(
              context: context, iconData: Icons.logout, title: 'Çıkış', onTap: (() => _signOut(context))),
        ], icon: _userCircleAvatar()),
      ];

  Padding _userCircleAvatar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Constants.darkPrimaryColor,
        child: _getCircleAvatar(),
      ),
    );
  }

  CircleAvatar _getCircleAvatar() {
    String? photoUrl;

    if (isStudent) {
      final student = Student.getStudentFormLocal();
      if (student != null) {
        photoUrl = student.photoUrl;
      }
    } else {
      final teacher = Teacher.getTeacherFormLocal();
      if (teacher != null) {
        photoUrl = teacher.photoUrl;
      }
    }

    if (photoUrl != null) {
      return CircleAvatar(
        radius: 17,
        backgroundImage: NetworkImage(
          photoUrl,
        ),
      );
    } else {
      return const CircleAvatar(
        backgroundColor: Constants.darkBackgroundColor,
        radius: 17,
        child: Icon(Icons.person),
      );
    }
  }

  void _signOut(BuildContext context) async {
    await SharedPrefs.instance.remove(PrefKeys.userID.toString());
    await SharedPrefs.instance.remove(PrefKeys.student.toString());
    await SharedPrefs.instance.remove(PrefKeys.teacher.toString());
    await FirebaseAuth.instance.signOut();
    context.router.replaceNamed(AppRoutes.routeMainAuth);
  }

  @override
  Widget? get leading => Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      );
}

class _AdminAppBarTitle extends StatelessWidget {
  const _AdminAppBarTitle({required this.isStudent, Key? key}) : super(key: key);
  final bool isStudent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (context.router.currentPath != AppRoutes.routeAdminDashboard) {
                context.router.replaceNamed(AppRoutes.routeAdminDashboard);
              }
            },
            child: Column(
              children: [
                const Text(
                  "Rehberlik Servisi",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
                Text(
                  isStudent ? 'Öğrenci Paneli' : 'Yönetici Paneli',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
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
      ],
    );
  }

  Future<dynamic> _showSearchDialog(String text, BuildContext context) {
    final dialog = showDialog(
        context: context,
        builder: (ctx) {
          return const AlertDialog();
        });

    return dialog;
  }
}
