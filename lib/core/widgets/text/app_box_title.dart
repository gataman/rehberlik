import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../common/constants.dart';

class AppBoxTitle extends StatelessWidget {
  final String title;
  final Color? color;
  final bool isBack;

  const AppBoxTitle({Key? key, required this.title, this.color, required this.isBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2),
      child: Row(
        children: [
          if (isBack)
            InkWell(
              onTap: () {
                context.router.navigateBack();
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Theme.of(context).primaryColor,
              ),
            ),
          if (isBack)
            const SizedBox(
              width: defaultPadding,
            ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
