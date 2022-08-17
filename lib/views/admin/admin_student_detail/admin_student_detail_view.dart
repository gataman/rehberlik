library admin_student_detail_view;

import 'admin_student_detail_imports.dart';

part 'components/student_detail_tab_view.dart';

part 'components/student_info_card.dart';

class AdminStudentDetailView extends StatelessWidget {
  const AdminStudentDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context) ? _mobileContent() : _desktopContent();
  }

  Widget _desktopContent() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                //StudentInfoCard(),
                StudentDetailTabView(),
              ],
            ),
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          Expanded(
            flex: 2,
            child: StudentInfoCard(),
          ),
        ],
      ),
    );
  }

  Widget _mobileContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StudentInfoCard(),
          const SizedBox(
            height: defaultPadding,
          ),
          Column(
            children: const [
              StudentDetailTabView(),
            ],
          ),
        ],
      ),
    );
  }
}
