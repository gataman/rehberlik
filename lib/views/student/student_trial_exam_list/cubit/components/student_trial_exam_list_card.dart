import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../common/navigaton/app_router/app_router.dart';
import '../../../../../models/trial_exam.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/widgets/default_circular_progress.dart';
import '../../../../../core/widgets/list_tiles/app_list_with_date_tile.dart';
import '../../../../../core/widgets/text/app_empty_warning_text.dart';
import '../student_trial_exam_list_cubit.dart';

class StudentTrialExamListCard extends StatelessWidget {
  const StudentTrialExamListCard({Key? key}) : super(key: key);
  final dateDifference = -15;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: minimumBoxHeight),
        child: Padding(
          padding: const EdgeInsets.only(bottom: defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getTitle(context),
              const Divider(
                thickness: 1,
                height: .5,
              ),
              _getTrialExamListBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTrialExamListBox() {
    return BlocBuilder<StudentTrialExamListCubit, StudentTrialExamListState>(
      builder: (context, state) {
        if (state is ListLoadedState) {
          return _listLoadedState(state.trialExamList);
        } else {
          return _loadingState();
        }
      },
    );
  }

  Widget _loadingState() {
    return const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress());
  }

  Widget _listLoadedState(List<TrialExam>? trialExamList) {
    if (trialExamList != null) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trialExamList.length,
        separatorBuilder: (context, index) => defaultDivider,
        itemBuilder: (context, index) {
          final trialExam = trialExamList[index];
          final difference = trialExam.examDate!.difference(DateTime.now()).inDays;
          return AppListWithDateTile(
              title: trialExam.examName!,
              detailOnPressed: () {
                _goTrialExamDetail(trialExam, context);
              },
              iconData: Icons.insert_chart,
              date: DateFormat("dd.MM.yyyy").format(trialExam.examDate!),
              isNew: difference >= dateDifference);
        },
      );
    } else {
      return const AppEmptyWarningText(text: 'Henüz deneme sınavı eklenmemiş!');
    }
  }

  Widget _getTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              'Deneme Sınavları',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Text(
            'Uygulanma Tarihi',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _goTrialExamDetail(TrialExam trialExam, BuildContext context) {
    context.router.navigate(StudentExamDetailRoute(trialExam: trialExam));
    //context.router.pushNamed(AppRoutes.routeStudentExamDetail);
  }
}
