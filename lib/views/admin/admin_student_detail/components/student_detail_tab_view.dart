part of admin_student_detail_view;

class StudentDetailTabView extends GetView<AdminStudentDetailController> {
  const StudentDetailTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              controller: controller.tabController,
              tabs: _getTabs(),
            ),
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              controller: controller.tabController,
              children: _getTabBarViews(),
            ),
          )
        ],
      ),
    );
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
    Student? student = controller.studentController.selectedStudent.value;
    //final _dateNow = DateTime.now();

    //"4Vmdx0gLlcN8N0qaB1PB";

    return <Widget>[
      //Text("detail"),
      if (student != null) StudentProgramDataGridCard(studentID: student.id!),
      if (student != null) StudentTimeTableCard(student: student),
      //const Text("istatistik"),
      const Text("Notlar"),
    ];
  }
}
