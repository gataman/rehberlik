import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../admin_base/admin_base_view.dart';
import 'components/agenda_box/agenda_box.dart';
import 'components/right_menu/right_side.dart';
import 'components/school_student_stats/school_student_stats_list.dart';

class AdminDashboardView extends AdminBaseView {
  AdminDashboardView({Key? key}) : super(key: key);

  final denemeList = <String>["Hız Yayınları 1", "Özdebir 1", "Startfen", "Özdebir 2"];

  @override
  Widget get firstView => Column(children: const [
        SchoolStudentStatsList(
          crossAxisCount: 4,
          childAspectRatio: 2,
        ),
        SizedBox(height: defaultPadding),
        AgendaBox(),
      ]);

  @override
  Widget get secondView => RightSide(denemeList: denemeList);

  @override
  bool get isDashboard => true;

/*
  @override
  Widget build(BuildContext context) {
    //final Size _size = MediaQuery.of(context).size;
    return Responsive(mobile: _mobileContent(context), tablet: _tabletContent(), desktop: _desktopContent());
  }

  Widget _desktopContent() {
    return SafeArea(
      child: Scaffold(
        appBar: AdminAppBar(),
        drawer: const AdminDrawerMenu(),
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const SchoolStudentStatsList(
                        crossAxisCount: 4,
                        childAspectRatio: 2,
                      ),
                      const SizedBox(height: defaultPadding),
                      AgendaBox(),
                    ],
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  flex: 2,
                  child: RightSide(denemeList: denemeList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabletContent() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const SchoolStudentStatsList(
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                ),
                const SizedBox(height: defaultPadding),
                AgendaBox(),
              ],
            ),
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          Expanded(
            flex: 2,
            child: RightSide(denemeList: denemeList),
          ),
        ],
      ),
    );
  }

  Widget _mobileContent(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SchoolStudentStatsList(
            crossAxisCount: 2,
            childAspectRatio: _size.width < 460
                ? 2.5
                : _size.width < 600
                    ? 3
                    : 4,
          ),
          const SizedBox(height: defaultPadding),
          AgendaBox(),
          const SizedBox(height: defaultPadding),
          RightSide(denemeList: denemeList),
        ],
      ),
    );
  }

   */
}
