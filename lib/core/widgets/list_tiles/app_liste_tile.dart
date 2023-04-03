import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../models/teacher.dart';

import '../../../common/constants.dart';
import '../../../views/admin/admin_base/cubit/teacher_cubit.dart';
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
    final teacherType = context.read<TeacherCubit>().teacherType;
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
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (editOnPressed != null && teacherType == TeacherType.admin)
                AppSmallRoundedButton(
                  onPressed: editOnPressed!,
                ),
              const SizedBox(width: defaultPadding),
              if (deleteOnPressed != null && teacherType == TeacherType.admin)
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
