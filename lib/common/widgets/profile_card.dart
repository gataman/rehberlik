import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/responsive.dart';

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
        color: secondaryColor,
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
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
