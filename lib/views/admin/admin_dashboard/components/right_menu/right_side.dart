part of admin_dashboard_view;

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
