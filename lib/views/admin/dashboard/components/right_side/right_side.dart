import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/dashboard/components/right_side/components/classes_drop_down_menu.dart';
import 'package:rehberlik/views/admin/dashboard/components/right_side/components/right_side_bar_chart.dart';
import 'package:rehberlik/views/admin/dashboard/components/right_side/components/trial_exams_list.dart';

class RightSide extends StatelessWidget {
  const RightSide({
    Key? key,
    required this.denemeList,
  }) : super(key: key);

  final List<String> denemeList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 500,
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.white10),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Deneme Sınavları",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          ClassesDropDownMenu(
            valueChanged: (index) {
              debugPrint("Seçilen right size index: $index");
            },
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          const RightSideBarChart(),
          TrialExamsList(denemeList: denemeList)
        ],
      ),
    );
  }
}
