import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/dashboard/admin_dashboard_controller.dart';
import 'package:rehberlik/views/admin/dashboard/components/center/components/school_student_stats_card.dart';

class SchoolStudentStatsList extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  final _controller = Get.put(AdminDashboardController());

  SchoolStudentStatsList({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 16 / 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_controller.schoolStudentStatsList.value == null) {
      _controller.getSchoolStudentStats();
    }
    return Obx(() {
      final schoolStudentStats = _controller.schoolStudentStatsList.value;
      if (schoolStudentStats != null) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: schoolStudentStats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: defaultPadding / 2,
            mainAxisSpacing: defaultPadding / 2,
          ),
          itemBuilder: (context, index) => SchoolStudentStatsCard(
              schoolStudentStats: schoolStudentStats[index]),
        );
      } else {
        return Container();
      }
    });
  }
}
