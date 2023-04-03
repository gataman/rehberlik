import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/widgets/loading_button.dart';
import '../../../admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import '../../cubit/trial_exam_result_cubit.dart';
import 'trial_exam_result_data_grid.dart';

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
                if (state.wrongStudentList != null || state.wrongRowList != null || state.duplicateNumberList != null)
                  Container(
                    margin: const EdgeInsets.only(right: defaultPadding),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
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
                  ),
                ),
              ],
            )),
        if (state.wrongStudentList != null)
          _getWronRowAlert(state.wrongStudentList!,
              'Bazı satırlardaki öğrenci numaraları eşleşmiyor lütfen kontrol edin.Bu satırlar :'),
        if (state.wrongRowList != null)
          _getWronRowAlert(
              state.wrongRowList!,
              'Bazı satırlarda doğru, yanlış sayılarında boşluklar veya sayısal olmayan '
              'karakterler mevcut. Lütfen excel dosyasını kontrol edin!'),
        if (state.duplicateNumberList != null)
          _getWronRowAlert(
              state.duplicateNumberList!, 'Aynı numaradan birden çok kayıt mevcut bu öğrenci numaraları: '),
        if (state.trialExamResultParsedList != null)
          TrialExamResultDataGrid(
            trialExamResultList: state.trialExamResultParsedList!,
          ),
        if (state.wrongRowList != null) ...state.wrongRowList!.map((row) => Text("Hatalı satır: $row")),
      ],
    );
  }

  _getWronRowAlert(List<int> wrongRowList, String message) {
    var wrongRows = StringBuffer();
    wrongRows.writeAll(wrongRowList, ', ');
    return Container(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      color: Colors.redAccent,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(message),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.report_problem,
                ),
                Text(
                  '  ${wrongRows.toString()}',
                  style: const TextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
