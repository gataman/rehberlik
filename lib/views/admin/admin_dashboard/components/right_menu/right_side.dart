part of admin_dashboard_view;

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
        color: darkSecondaryColor,
        border: Border.all(color: Colors.white10),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
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
    );
  }
}
