part of admin_dashboard_view;

class SchoolStudentStatsList extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;

  const SchoolStudentStatsList({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 16 / 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('dashboard');
    return BlocBuilder<ClassListCubit, ClassListState>(builder: (context, state) {
      if (state is ClassListLoadingState) {
        return buildGridView(state.schoolStatsList);
      } else {
        return buildGridView((state as ClassListLoadedState).schoolStatsList);
      }
    });
  }

  GridView buildGridView(List<SchoolStudentStats> schoolStudentStats) {
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
      itemBuilder: (context, index) => SchoolStudentStatsCard(schoolStudentStats: schoolStudentStats[index]),
    );
  }
}
