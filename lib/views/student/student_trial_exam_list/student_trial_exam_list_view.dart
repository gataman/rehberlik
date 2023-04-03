import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../student_base/student_base_view.dart';
import 'cubit/components/student_trial_exam_list_card.dart';

import '../../../common/constants.dart';
import '../../../common/navigaton/app_router/app_routes.dart';
import '../../../core/widgets/text/app_menu_title.dart';

class StudentTrialExamListView extends StudentBaseView {
  const StudentTrialExamListView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const StudentTrialExamListCard();

  @override
  Widget get secondView => _ViewMenu();

  @override
  bool get isFullPage => false;

  @override
  bool get isDashboard => true;
}

class _ViewMenu extends StatelessWidget {
  _ViewMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: minimumBoxHeight,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppMenuTitle(
              title: 'Menü',
              color: Theme.of(context).colorScheme.primary,
            ),
            _trialExamStudentResultButton(context)
          ],
        ),
      ),
    );
  }

  Widget _trialExamStudentResultButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            context.router.replaceNamed(AppRoutes.routeStudentTrialExam);
          },
          icon: const Icon(Icons.line_axis_rounded),
          label: const Text('Öğrenci Başarı Karnesi'),
        ),
      ),
    );
  }
}
