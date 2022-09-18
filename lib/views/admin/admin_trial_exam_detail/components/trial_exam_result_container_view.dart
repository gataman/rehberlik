part of admin_trial_exam_result_view;

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
        context: context, message: result.message, type: result.isSuccess ? DialogType.success : DialogType.error);
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
              return const TrialExamResultStaticsView();
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
