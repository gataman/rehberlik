import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StudentDrawerListTile extends StatelessWidget {
  final String title;
  final String iconSrc;
  final VoidCallback onPress;
  final Color? tileColor;

  const StudentDrawerListTile(
      {Key? key, required this.title, required this.iconSrc, required this.onPress, this.tileColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tileColor,
      horizontalTitleGap: 0.0,
      onTap: onPress,
      leading: SvgPicture.asset(
        iconSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54, fontSize: 16),
      ),
    );
  }
}
