import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/constants.dart';
import '../../../admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import '../../cubit/trial_exam_result_cubit.dart';

class TrialExamResultDefaultView extends StatelessWidget {
  const TrialExamResultDefaultView({Key? key, required this.classLevel, required this.message}) : super(key: key);

  final int classLevel;
  final String message;

  @override
  Widget build(BuildContext context) {
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () {
                final classCubit = context.read<ClassListCubit>();
                context.read<TrialExamResultCubit>().selectExcelFile(classCubit: classCubit, classLevel: classLevel);
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
}
