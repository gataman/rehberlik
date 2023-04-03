import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../admin_trial_exam_detail/components/states/trial_exam_result_statics_view.dart';
import 'components/trial_exam_total_averages_data_table.dart';

import '../../../common/constants.dart';
import '../../../common/widgets/default_circular_progress.dart';
import 'cubit/trial_exam_total_cubit.dart';

class TrialExamTotalContainer extends StatelessWidget {
  const TrialExamTotalContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrialExamTotalCubit, TrialExamTotalState>(
      builder: (context, state) {
        if (state is TrialExamTotalLoadedState) {
          final trialExamStudentResult = state.trialExamStudentResult;
          if (trialExamStudentResult != null && trialExamStudentResult.isNotEmpty) {
            return TrialExamTotalAveragesDataTable(trialExamStudentResultList: trialExamStudentResult);
          } else {
            return const Text('Sonuç bulunamadı');
          }
        } else if (state is TrialExamTotalGraphState) {
          return TrialExamResultStaticsView(
            trialExamGraphList: state.trialExamGraphList,
          );
        } else {
          return _loadingState('Sonuçlar yükleniyor, lütfen bekleyin...');
        }
      },
    );
  }

  Widget _loadingState(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: defaultPadding, height: defaultPadding, child: DefaultCircularProgress()),
        const SizedBox(
          height: defaultPadding,
        ),
        Text(message),
      ],
    );
  }
}
