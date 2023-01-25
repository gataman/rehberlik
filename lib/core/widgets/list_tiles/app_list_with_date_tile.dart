import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants.dart';
import '../buttons/app_small_rounded_button.dart';

class AppListWithDateTile extends StatelessWidget {
  final String title;
  final String date;
  final IconData? iconData;
  final VoidCallback? deleteOnPressed;
  final VoidCallback? detailOnPressed;
  final VoidCallback? editOnPressed;
  final String? svgData;
  final bool isNew;

  const AppListWithDateTile(
      {Key? key,
      required this.title,
      this.iconData,
      this.deleteOnPressed,
      this.detailOnPressed,
      this.editOnPressed,
      this.svgData,
      required this.date,
      required this.isNew})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      hoverColor: Theme.of(context).dividerColor,
      //splashColor: darkBackColor,
      onTap: detailOnPressed,
      child: ListTile(
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
          title: Row(
            //mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (isNew)
                      Text(
                        '  Yeni',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.redAccent),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                date,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
              ),
              const Spacer(),
            ],
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
    );
  }
}
