part of admin_trial_exam_result_view;

class TrialExamResultUploadedView extends StatelessWidget {
  final TrialExamResultUploadedState state;
  final ValueNotifier<bool> buttonListener;
  final VoidCallback onClick;
  final int classLevel;

  const TrialExamResultUploadedView(
      {Key? key, required this.state, required this.buttonListener, required this.onClick, required this.classLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Verileri kontrol ettikten sonra sisteme kaydedin!'),
        Container(
            margin: const EdgeInsets.only(bottom: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.wrongStudentList != null || state.wrongRowList != null)
                  Container(
                    margin: const EdgeInsets.only(right: defaultPadding),
                    child: ElevatedButton.icon(
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
                        'Tekrar Yükle',
                        style: TextStyle(color: darkBackColor),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 200,
                  child: LoadingButton(
                    text: 'Sisteme Kaydet',
                    loadingListener: buttonListener,
                    onPressed: onClick,
                    textColor: darkBackColor,
                  ),
                ),
              ],
            )),
        if (state.wrongStudentList != null) _getWronRowAlert(state.wrongStudentList!, false),
        if (state.wrongRowList != null) _getWronRowAlert(state.wrongRowList!, true),
        if (state.trialExamResultParsedList != null)
          TrialExamResultDataGrid(
            trialExamResultList: state.trialExamResultParsedList!,
          ),
        if (state.wrongRowList != null) ...state.wrongRowList!.map((row) => Text("Hatalı satır: ${row}")),
      ],
    );
  }

  _getWronRowAlert(List<int> wrongRowList, bool isWrongRow) {
    var wrongRows = StringBuffer();
    wrongRows.writeAll(wrongRowList, ', ');
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      color: Colors.redAccent,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.report_problem,
                ),
                Text(
                  ' Hatalı Satırlar: ${wrongRows.toString()}',
                  style: const TextStyle(),
                ),
              ],
            ),
            Text(isWrongRow
                ? 'Bazı satırlarda doğru, yanlış sayılarında boşluklar veya sayısal olmayan '
                    'karakterler mevcut. Lütfen excel dosyasını kontrol edin!'
                : 'Bazı satırlardaki öğrenci numaraları eşleşmiyor lütfen kontrol edin'),
          ],
        ),
      ),
    );
  }
}
