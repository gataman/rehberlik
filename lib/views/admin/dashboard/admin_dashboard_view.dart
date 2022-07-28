import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/class_stats.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/dashboard/components/center/components/agenda_box.dart';
import 'package:rehberlik/views/admin/dashboard/components/center/components/school_student_stats_list.dart';
import 'package:rehberlik/views/admin/dashboard/components/right_side/right_side.dart';

class AdminDashboardView extends StatelessWidget {
  AdminDashboardView({Key? key}) : super(key: key);

  final denemeList = <String>[
    "Hız Yayınları 1",
    "Özdebir 1",
    "Startfen",
    "Özdebir 2"
  ];

  @override
  Widget build(BuildContext context) {
    //final Size _size = MediaQuery.of(context).size;

    return Responsive(
        mobile: _mobileContent(context),
        tablet: _tabletContent(),
        desktop: _desktopContent());
  }

  Widget _desktopContent() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                SchoolStudentStatsList(
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

  Widget _tabletContent() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                SchoolStudentStatsList(
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
}

/*

Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Responsive(
                mobile: ClassStatsList(
                  classStats: classStats,
                  crossAxisCount: 2,
                  childAspectRatio: _size.width < 460
                      ? 2.5
                      : _size.width < 600
                          ? 3
                          : 4,
                ),
                tablet: ClassStatsList(
                  classStats: classStats,
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                ),
                desktop: ClassStatsList(
                  classStats: classStats,
                  crossAxisCount: 4,
                  childAspectRatio: _size.width < 1400 ? 2 : 1.6,
                ),
              ),
              const SizedBox(height: defaultPadding),
              Expanded(child: AgendaBox()),
              if (Responsive.isMobile(context))
                const SizedBox(
                  height: defaultPadding,
                ),
              if (Responsive.isMobile(context))
                RightSide(denemeList: denemeList),
            ],
          ),
        ),
        if (!Responsive.isMobile(context))
          const SizedBox(
            width: defaultPadding,
          ),
        if (!Responsive.isMobile(context))
          Expanded(
            flex: 2,
            child: RightSide(denemeList: denemeList),
          ),
      ],
    );
 */
