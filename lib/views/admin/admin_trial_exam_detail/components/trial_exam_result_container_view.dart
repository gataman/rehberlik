part of admin_trial_exam_result_view;

class TrialExamResultContainerView extends StatelessWidget {
  TrialExamResultContainerView({Key? key}) : super(key: key);

  final ValueNotifier<bool> buttonListener = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final trialExam = context.read<TrialExamResultCubit>().trialExam;

    return AppBoxContainer(
      child: Column(
        children: [
          AppBoxTitle(title: trialExam!.examName ?? ''),
          BlocBuilder<TrialExamResultCubit, TrialExamResultState>(builder: (context, state) {
            if (state is TrialExamResultListLoadingState) {
              return _loadingState('Sonuçlar kontrol ediliyor... Lütfen bekleyin!');
            } else if (state is TrialExamResultUploadingState) {
              return _loadingState('Dosya yükleniyor... Lütfen bekleyin!');
            } else if (state is TrialExamResultErrorState) {
              return _defaultState(
                  context: context, classLevel: trialExam.classLevel!, message: state.message);
            } else if (state is TrialExamResultListLoadedState) {
              return _listLoadedState(state);
            } else if (state is TrialExamResultUploadedState) {
              return TrialExamResultUploadedView(
                  classLevel: trialExam.classLevel ?? 5,
                  state: state,
                  buttonListener: buttonListener,
                  onClick: () {
                    _saveData(context);
                  });
            } else {
              return _defaultState(
                  context: context,
                  classLevel: trialExam.classLevel!,
                  message: 'Sonuç bulunamadı. Yüklemek için tıklayınız.');
            }
          }),
        ],
      ),
    );
  }

  Widget _loadingState(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: defaultPadding, height: defaultPadding, child: const DefaultCircularProgress()),
        const SizedBox(
          height: defaultPadding,
        ),
        Text(message),
      ],
    );
  }

  Widget _listLoadedState(TrialExamResultListLoadedState state) {
    return TrialExamResultDataGrid(trialExamResultList: state.trialExamResultList);
  }

  Widget _defaultState({required BuildContext context, required int classLevel, required String message}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: defaultPadding * 3,
        ),
        const Center(child: Text("Sonuç bulunamadı. Yüklemek için tıklayınız.")),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.amber),
              onPressed: () {
                final classCubit = context.read<ClassListCubit>();
                context
                    .read<TrialExamResultCubit>()
                    .selectExcelFile(classCubit: classCubit, classLevel: classLevel);
              },
              icon: const Icon(
                Icons.upload,
                color: darkBackColor,
              ),
              label: const Text(
                'Sınav Sonuçları Yükle',
                style: TextStyle(color: darkBackColor),
              ),
            ),
          ],
        )
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
        type: result.isSuccess ? DialogType.success : DialogType.error);
  }
}
