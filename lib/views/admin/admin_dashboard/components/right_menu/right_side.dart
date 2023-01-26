import 'package:flutter/material.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/widgets/classes_drop_down_menu.dart';
import '../../../../../core/widgets/text/app_menu_title.dart';
import 'right_side_bar_chart.dart';
import 'trial_exams_list.dart';

class RightSide extends StatelessWidget {
  const RightSide({
    Key? key,
    required this.denemeList,
  }) : super(key: key);

  final List<String> denemeList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const AppMenuTitle(title: 'Deneme Sınavları'),
            const SizedBox(
              height: defaultPadding,
            ),
            ClassesDropDownMenu(
              valueChanged: (index) {},
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            const RightSideBarChart(),
            TrialExamsList(denemeList: denemeList)
          ],
        ),
      ),
    );
  }
}
