library admin_dashboard_view;

import 'admin_dashboard_imports.dart';
import 'package:intl/intl.dart';

part 'components/school_student_stats/school_student_stats_list.dart';

//AgendaBox
part 'components/agenda_box/agenda_box.dart';
part 'components/agenda_box/agenda_box_new_event_alert_dialog.dart';
part 'components/agenda_box/meeting_type_select_box.dart';

//RightMenu
part 'components/right_menu/right_side.dart';
part 'components/right_menu/right_side_bar_chart.dart';
part 'components/right_menu/trial_exams_list.dart';

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
}
