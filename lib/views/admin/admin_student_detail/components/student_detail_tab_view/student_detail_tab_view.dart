import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../../common/constants.dart';
import '../../../../../models/student.dart';
import 'question_follow/question_follow_list_card.dart';
import 'time_table/student_time_table_card.dart';

class StudentDetailTabView extends StatefulWidget {
  final Student student;

  const StudentDetailTabView({Key? key, required this.student}) : super(key: key);

  @override
  State<StudentDetailTabView> createState() => _StudentDetailTabViewState();
}

class _StudentDetailTabViewState extends State<StudentDetailTabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Student student;

  @override
  void initState() {
    student = widget.student;
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              labelStyle: Theme.of(context).textTheme.bodyMedium,
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

  /*
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

   */

  List<Widget> _getTabs() {
    return <Widget>[
      _tabContainer(icon: Icons.stacked_bar_chart, labelText: 'Soru Takibi'),
      _tabContainer(icon: Icons.calendar_month, labelText: 'Çalışma Programı'),
      //_tabContainer(icon: Icons.contact_page, labelText: 'Notlar'),
    ];
  }

  Container _tabContainer({required IconData icon, required String labelText}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(
            height: defaultPadding / 4,
          ),
          AutoSizeText(
            labelText,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  List<Widget> _getTabBarViews() {
    return <Widget>[
      QuestionFollowListCard(
        studentID: student.id!,
        isStudent: false,
      ),
      StudentTimeTableCard(student: student),
      //const Text("istatistik"),
      // const Text("Notlar"),
    ];
  }
}
