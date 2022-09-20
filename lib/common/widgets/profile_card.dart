import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/navigaton/app_router/app_routes.dart';
import 'package:rehberlik/core/init/pref_keys.dart';

import '../../core/init/locale_manager.dart';
import '../../models/student.dart';
import '../../responsive.dart';
import '../constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Student? student = Student.getStudentFormLocal();
    return Container(
      height: 40,
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
        color: darkSecondaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: student != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      student.photoUrl!,
                    ),
                  )
                : const CircleAvatar(
                    backgroundImage: AssetImage(
                      "${imagesSrc}profile.jpeg",
                    ),
                  ),
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                student != null ? student.studentName! : '',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          InkWell(
              onTap: () async {
                _signOut(context);
              },
              child: const Icon(Icons.keyboard_arrow_down)),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) async {
    await SharedPrefs.instance.remove(PrefKeys.userID.toString());
    await FirebaseAuth.instance.signOut();
    context.router.replaceNamed(AppRoutes.routeMainAuth);
  }
}
