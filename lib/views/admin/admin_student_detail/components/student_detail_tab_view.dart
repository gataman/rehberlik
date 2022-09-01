part of admin_student_detail_view;

class StudentDetailTabView extends StatefulWidget {
  const StudentDetailTabView({Key? key}) : super(key: key);

  @override
  State<StudentDetailTabView> createState() => _StudentDetailTabViewState();
}

class _StudentDetailTabViewState extends State<StudentDetailTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Student? _student;

  @override
  void initState() {
    var args = Get.arguments;

    if (args != null) {
      _student = args["student"];
    }

    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_student != null) {
      return Container(
        decoration: defaultBoxDecoration,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                //color: infoColor,
              ),
              child: TabBar(
                indicatorColor: Colors.amber,
                controller: _tabController,
                tabs: _getTabs(),
              ),
            ),
            SizedBox(
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: _getTabBarViews(),
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  List<Tab> _getTabs() {
    return <Tab>[
      const Tab(
        icon: Icon(Icons.stacked_bar_chart),
        text: "Soru Takibi",
      ),
      const Tab(
        iconMargin: EdgeInsets.only(bottom: 4),
        icon: Icon(Icons.calendar_month),
        text: "Çalışma Programı",
      ),
      const Tab(
        icon: Icon(Icons.contact_page),
        text: "Notlar",
      ),
    ];
  }

  List<Widget> _getTabBarViews() {
    return <Widget>[
      //Text("detail"),
      if (_student != null)
        StudentProgramDataGridCard(studentID: _student!.id!),
      if (_student != null) StudentTimeTableCard(student: _student!),
      //const Text("istatistik"),
      const Text("Notlar"),
    ];
  }
}
