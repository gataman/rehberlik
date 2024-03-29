import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/student_login_view.dart';
import 'components/teacher_login_view.dart';
import 'cubit/auth_cubit.dart';

import '../../common/constants.dart';
import '../../core/widgets/containers/app_list_box_container.dart';

// ignore: must_be_immutable
class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  double profileImageSize = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => AuthCubit(),
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: profileImageSize / 2),
                    child: SizedBox(
                      width: 350,
                      child: AppBoxContainer(child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              _topNavigationBar(context, state),
                              (state.activeIndex == 0) ? const StudentLoginView() : const TeacherLoginView(),
                            ],
                          );
                        },
                      )),
                    ),
                  ),
                  _profileImageContainer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _topNavigationBar(BuildContext context, AuthState state) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Öğrenci Girişi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Yönetici Girişi',
            ),
          ],
          currentIndex: state.activeIndex,
          onTap: (index) {
            context.read<AuthCubit>().changeActiveIndex(index: index);
          },
        ),
      ),
    );
  }

  Container _profileImageContainer() {
    return Container(
      width: profileImageSize,
      height: profileImageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: darkSecondaryColor,
        border: Border.all(color: Colors.white10),
      ),
      child: Image.asset("${imagesSrc}logo.png"),
    );
  }
}
