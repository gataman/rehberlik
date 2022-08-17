part of admin_dashboard_view;

class SchoolStudentStatsList extends GetView<AdminDashboardController> {
  final int crossAxisCount;
  final double childAspectRatio;

  const SchoolStudentStatsList({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 16 / 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.schoolStudentStatsList.value == null) {
      controller.getSchoolStudentStats();
    }
    return Obx(() {
      final schoolStudentStats = controller.schoolStudentStatsList.value;
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
