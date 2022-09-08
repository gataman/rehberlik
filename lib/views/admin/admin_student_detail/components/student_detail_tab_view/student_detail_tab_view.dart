library student_detail_tab_view;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/core/widgets/containers/app_time_table_card_item.dart';
import 'package:rehberlik/models/study_program.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:rehberlik/models/student.dart';
import 'study_program/core/study_program_selection_controller.dart';
import 'study_program/cubit/study_program_list_cubit.dart';
import 'time_table/cubit/time_table_list_cubit.dart';
import 'time_table/student_time_table_add_dialog.dart';

part 'study_program/student_program_card.dart';
part 'study_program/core/study_program_data_source.dart';
part 'time_table/student_time_table_card.dart';
part 'time_table/core/student_time_table_data_source.dart';

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
              labelStyle: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
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
      _tabContainer(icon: Icons.contact_page, labelText: 'Notlar'),
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
          ),
          const SizedBox(
            height: defaultPadding / 4,
          ),
          AutoSizeText(labelText),
        ],
      ),
    );
  }

  List<Widget> _getTabBarViews() {
    return <Widget>[
      StudentProgramCard(studentID: student.id!),
      StudentTimeTableCard(student: student),
      //const Text("istatistik"),
      const Text("Notlar"),
    ];
  }
}
