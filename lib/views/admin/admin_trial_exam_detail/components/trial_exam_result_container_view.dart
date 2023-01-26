import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants.dart';
import '../../../../common/custom_dialog.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../core/widgets/containers/app_list_box_container.dart';
import '../../../../core/widgets/text/app_box_title.dart';
import '../cubit/trial_exam_result_cubit.dart';
import 'states/trial_exam_result_data_grid.dart';
import 'states/trial_exam_result_default_view.dart';
import 'states/trial_exam_result_statics_view.dart';
import 'states/trial_exam_result_uploaded_view.dart';

class TrialExamResultContainerView extends StatelessWidget {
  TrialExamResultContainerView({Key? key}) : super(key: key);

  final ValueNotifier<bool> buttonListener = ValueNotifier(false);

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

  void _saveData(BuildContext context) async {
    buttonListener.value = true;
    final result = await context.read<TrialExamResultCubit>().saveTrialExamResult();

    buttonListener.value = false;
    CustomDialog.showSnackBar(
      context: context,
      message: result.message,
      type: result.isSuccess ? DialogType.success : DialogType.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final trialExam = context.read<TrialExamResultCubit>().trialExam;

    return AppBoxContainer(
      child: Column(
        children: [
          AppBoxTitle(isBack: true, title: trialExam!.examName ?? ''),
          BlocBuilder<TrialExamResultCubit, TrialExamResultState>(builder: (context, state) {
            if (state is TrialExamResultListLoadingState) {
              return _loadingState('Sonuçlar kontrol ediliyor... Lütfen bekleyin!');
            } else if (state is TrialExamResultUploadingState) {
              return _loadingState('Dosya yükleniyor... Lütfen bekleyin!');
            } else if (state is TrialExamResultErrorState) {
              return TrialExamResultDefaultView(
                classLevel: trialExam.classLevel!,
                message: state.message,
              );
            } else if (state is TrialExamResultListLoadedState) {
              return TrialExamResultDataGrid(trialExamResultList: state.trialExamResultList);
            } else if (state is TrialExamResultUploadedState) {
              return TrialExamResultUploadedView(
                  classLevel: trialExam.classLevel ?? 5,
                  state: state,
                  buttonListener: buttonListener,
                  onClick: () {
                    _saveData(context);
                  });
            } else if (state is TrialExamResultStaticsState) {
              return TrialExamResultStaticsView(
                trialExamGraphList: state.trialExamGraphList,
              );
            } else {
              return TrialExamResultDefaultView(
                classLevel: trialExam.classLevel!,
                message: 'Sonuç bulunamadı, yüklemek için tıklayın!',
              );
            }
          }),
        ],
      ),
    );
  }
}
