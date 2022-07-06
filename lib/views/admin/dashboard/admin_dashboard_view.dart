import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/class_stats.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/dashboard/components/center/components/agenda_box.dart';
import 'package:rehberlik/views/admin/dashboard/components/center/components/class_stats_list.dart';
import 'package:rehberlik/views/admin/dashboard/components/footer.dart';
import 'package:rehberlik/views/admin/dashboard/components/header.dart';
import 'package:rehberlik/views/admin/dashboard/components/right_side/right_side.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final classStats = <ClassStats>[
      ClassStats(
        classLevel: 5,
        totalStudent: 125,
        classColor: Colors.redAccent,
      ),
      ClassStats(
        classLevel: 6,
        totalStudent: 112,
        classColor: Colors.lime,
      ),
      ClassStats(
        classLevel: 7,
        totalStudent: 112,
        classColor: Colors.lightBlueAccent,
      ),
      ClassStats(
        classLevel: 8,
        totalStudent: 103,
        classColor: Colors.amber,
      ),
    ];

    final denemeList = <String>[
      "Hız Yayınları 1",
      "Özdebir 1",
      "Startfen",
      "Özdebir 2"
    ];
    return Row(
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
              const AgendaBox(),
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
  }
}
