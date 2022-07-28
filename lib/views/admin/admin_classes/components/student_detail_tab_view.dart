import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';
import 'package:rehberlik/views/admin/admin_study_program/components/student_program_data_grid_card.dart';

class StudentDetailTabView extends StatefulWidget {
  const StudentDetailTabView({Key? key}) : super(key: key);

  @override
  State<StudentDetailTabView> createState() => _StudentDetailTabViewState();
}

class _StudentDetailTabViewState extends State<StudentDetailTabView>
    with SingleTickerProviderStateMixin {
  final _controller = Get.put(AdminClassesController());
  late TabController _tabController;

  @override
  void initState() {
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
  }

  List<Tab> _getTabs() {
    return <Tab>[
      const Tab(
        iconMargin: EdgeInsets.only(bottom: 4),
        icon: Icon(Icons.calendar_month),
        text: "Çalışma Programı",
      ),
      const Tab(
        icon: Icon(Icons.stacked_bar_chart),
        text: "Deneme İstatistikleri",
      ),
      const Tab(
        icon: Icon(Icons.contact_page),
        text: "Notlar",
      ),
    ];
  }

  List<Widget> _getTabBarViews() {
    Student? student = _controller.selectedStudent.value;
    final _dateNow = DateTime.now();
    final _startTime = DateTime(_dateNow.year, _dateNow.month, _dateNow.day);
    String? _studentID;
    if (student != null) {
      _studentID = student.id;
    }
    //"4Vmdx0gLlcN8N0qaB1PB";

    return <Widget>[
      if (_studentID != null)
        StudentProgramDataGridCard(
            studentID: _studentID, startTime: _startTime),
      const Text("Deneme İstatistikleri"),
      const Text("Notlar"),
    ];
  }
}
