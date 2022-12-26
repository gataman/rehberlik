import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/core/widgets/popup_menu/custom_popup_menu_button.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'package:rehberlik/views/app_main/search/search_student_dialog.dart';

import '../../core/init/locale_manager.dart';
import '../../core/init/pref_keys.dart';
import '../../models/student.dart';
import '../../models/teacher.dart';
import '../../views/app_main/cubit/app_main_cubit.dart';
import '../../views/app_main/search/cubit/search_student_cubit.dart';
import '../constants.dart';
import '../navigaton/app_router/app_routes.dart';

class CustomAppBar extends AppBar {
  final BuildContext context;
  final bool isStudent;

  CustomAppBar({required this.context, this.isStudent = false, Key? key}) : super(key: key);

  @override
  Widget? get title => _AdminAppBarTitle(
        isStudent: isStudent,
        mainContext: context,
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
  const _AdminAppBarTitle({required this.isStudent, Key? key, required this.mainContext}) : super(key: key);
  final bool isStudent;
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isDesktop = Responsive.isDesktop(context);
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
                Text(
                  "Rehberlik Servisi",
                  style: TextStyle(fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
                Text(
                  isStudent ? 'Öğrenci Paneli' : 'Yönetici Paneli',
                  style: TextStyle(fontSize: isMobile ? 10 : 12, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        const Spacer(
          flex: 4,
        ),
        if (!isStudent)
          BlocBuilder<ClassListCubit, ClassListState>(
            builder: (_, state) {
              if (state is ClassListLoadedState) {
                final studentList = state.allStudentList;
                if (studentList != null) {
                  context.read<SearchStudentCubit>().init(studentList);
                  if (isDesktop) {
                    return Expanded(child: _getSearchButton(context, studentList, isMobile));
                  } else {
                    return Container(
                      decoration: defaultBoxDecoration,
                      child: IconButton(
                        onPressed: () {
                          _showSearchDialog(mainContext, studentList);
                        },
                        icon: const Icon(Icons.search),
                      ),
                    );
                  }
                }
              }
              return Container();
            },
          ),
      ],
    );
  }

  ElevatedButton _getSearchButton(BuildContext context, List<Student> studentList, bool isMobile) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Constants.darkCanvasColor, side: const BorderSide(color: Constants.darkDividerColor)),
      child: Row(children: [
        const Icon(Icons.search, size: 20, color: Colors.white38),
        Expanded(
            child: Center(
          child: Text(
            'Öğrenci Arama',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white38),
          ),
        ))
      ]),
      onPressed: () {
        _showSearchDialog(mainContext, studentList);
      },
    );
  }

  Future<dynamic> _showSearchDialog(BuildContext mainContext, List<Student> allStudentList) {
    final dialog = showDialog(
        context: mainContext,
        builder: (ctx) {
          return SearchStudentDialog(
            allStudentList: allStudentList,
            mainContext: mainContext,
          );
        });

    return dialog;
  }
}
