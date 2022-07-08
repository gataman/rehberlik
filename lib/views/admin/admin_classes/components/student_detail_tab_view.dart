import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';

class StudentDetailTabView extends StatefulWidget {
  const StudentDetailTabView({Key? key}) : super(key: key);

  @override
  State<StudentDetailTabView> createState() => _StudentDetailTabViewState();
}

class _StudentDetailTabViewState extends State<StudentDetailTabView>
    with SingleTickerProviderStateMixin {
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
    return <Widget>[
      const Text("Çalışma Programı"),
      const Text("Deneme İstatistikleri"),
      const Text("Notlar"),
    ];
  }
}
