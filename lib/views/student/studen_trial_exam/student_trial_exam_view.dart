import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/navigaton/app_router/app_routes.dart';
import '../../../common/constants.dart';
import '../../../common/helper/excel_creator/student_trial_exam_excel_creator.dart';
import '../../../core/widgets/containers/app_list_box_container.dart';
import '../../../core/widgets/text/app_box_title.dart';
import '../../../core/widgets/text/app_menu_title.dart';
import '../../../models/student.dart';
import '../../admin/admin_student_detail/components/student_detail_tab_view/time_table/student_time_table_card.dart';
import '../../admin/admin_student_trial_exam_detail_view/components/student_trial_exam_detail_container_view.dart';
import '../student_base/student_base_view.dart';

class StudentTrialExamView extends StudentBaseView {
  const StudentTrialExamView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const StudentTrialExamDetailContainerView();

  @override
  Widget get secondView => _StudentTrialExamMenuContainer();

  @override
  bool get isDashboard => true;
}

class _StudentTrialExamContainer extends StatelessWidget {
  _StudentTrialExamContainer({Key? key}) : super(key: key);
  final student = Student.getStudentFormLocal();

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(
        child: Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Column(
        children: [
          const AppBoxTitle(title: 'Deneme Sınavı İstatistikleri', isBack: false),
          StudentTimeTableCard(student: student!),
        ],
      ),
    ));
  }
}

class _StudentTrialExamMenuContainer extends StatelessWidget {
  _StudentTrialExamMenuContainer({Key? key}) : super(key: key);
  final student = Student.getStudentFormLocal();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: minimumBoxHeight,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppMenuTitle(
              title: 'İşlemler',
              color: Theme.of(context).colorScheme.primary,
            ),
            _examListButton(context),
            _downloadButton(context)
          ],
        ),
      ),
    );
  }

  Widget _downloadButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            StudentTrialExamExcelCreator(context).build();
          },
          icon: const Icon(Icons.download),
          label: const Text('Deneme Sonuçlarını İndir'),
        ),
      ),
    );
  }

  Widget _examListButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            context.router.replaceNamed(AppRoutes.routeStudentTrialExamList);
          },
          icon: const Icon(Icons.fact_check),
          label: const Text('Deneme Sınavları'),
        ),
      ),
    );
  }
}
