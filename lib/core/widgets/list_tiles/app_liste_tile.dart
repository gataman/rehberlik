import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants.dart';
import '../../init/extentions.dart';
import '../buttons/app_small_rounded_button.dart';

class AppListTile extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final VoidCallback? deleteOnPressed;
  final VoidCallback? detailOnPressed;
  final VoidCallback? editOnPressed;
  final String? svgData;

  const AppListTile(
      {Key? key,
      required this.title,
      this.iconData,
      this.deleteOnPressed,
      this.detailOnPressed,
      this.editOnPressed,
      this.svgData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: defaultDividerDecoration,
      child: Material(
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          hoverColor: Colors.white.withOpacity(0.04),
          splashColor: darkBackColor,
          onTap: detailOnPressed,
          child: ListTile(
              horizontalTitleGap: 0.3,
              leading: iconData != null
                  ? Icon(
                      iconData,
                      size: 20,
                      color: infoColor,
                    )
                  : svgData != null
                      ? SvgPicture.asset(
                          svgData ?? "${iconsSrc}menu_classroom.svg",
                          color: infoColor,
                          height: 16,
                        )
                      : null,
              title: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: context.normalTextStyle,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (editOnPressed != null)
                    AppSmallRoundedButton(
                      onPressed: editOnPressed!,
                    ),
                  const SizedBox(width: defaultPadding),
                  if (deleteOnPressed != null)
                    AppSmallRoundedButton(
                      bgColor: Colors.redAccent,
                      iconData: Icons.delete,
                      onPressed: deleteOnPressed!,
                    ),
                ],
              )),
        ),
      ),
    );
  }
}
