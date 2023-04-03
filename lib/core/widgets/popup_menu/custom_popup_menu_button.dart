import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget icon;

  const CustomPopupMenuButton({
    Key? key,
    required this.menuList,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return menuList;
      },
      icon: icon,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      position: PopupMenuPosition.under,
      color: Theme.of(context).canvasColor,
      elevation: 10,
    );
  }

  static PopupMenuItem<dynamic> createMenuItem(
      {required BuildContext context, required IconData iconData, required String title, Function()? onTap}) {
    return PopupMenuItem(
        onTap: onTap,
        child: ListTile(
          leading: Icon(iconData),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ));
  }
}
