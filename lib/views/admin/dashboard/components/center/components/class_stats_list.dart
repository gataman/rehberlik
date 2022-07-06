import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/class_stats.dart';
import 'package:rehberlik/views/admin/dashboard/components/center/components/class_stats_card.dart';

class ClassStatsList extends StatelessWidget {
  final List<ClassStats>? classStats;
  final int crossAxisCount;
  final double childAspectRatio;

  const ClassStatsList({
    Key? key,
    this.classStats,
    this.crossAxisCount = 4,
    this.childAspectRatio = 16 / 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: classStats?.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: defaultPadding / 2,
        mainAxisSpacing: defaultPadding / 2,
      ),
      itemBuilder: (context, index) =>
          ClassStatsCard(classStats: classStats![index]),
    );
  }
}
