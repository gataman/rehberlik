part of admin_dashboard_view;

class TrialExamsList extends StatelessWidget {
  const TrialExamsList({
    Key? key,
    required this.denemeList,
  }) : super(key: key);

  final List<String> denemeList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: denemeList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 30,
            child: ListTile(
              leading: const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: primaryColor,
                size: 14,
              ),
              horizontalTitleGap: 0.0,
              minLeadingWidth: 20,
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                denemeList[index],
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Wrap(
                spacing: 12,
                children: [
                  Icon(
                    Icons.edit,
                    size: 14,
                    color: Colors.green[300],
                  ),
                  Icon(
                    Icons.delete,
                    size: 14,
                    color: Colors.red[300],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        });
  }
}
