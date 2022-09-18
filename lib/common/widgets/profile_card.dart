import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/navigaton/app_router/app_routes.dart';
import 'package:rehberlik/core/init/pref_keys.dart';

import '../../core/init/locale_manager.dart';
import '../../responsive.dart';
import '../constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(
            width: 32,
            height: 32,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                "${imagesSrc}profile.jpeg",
              ),
            ),
          ),
          if (!Responsive.isMobile(context))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                "Gürcan Ataman",
                style: TextStyle(fontSize: 14),
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
