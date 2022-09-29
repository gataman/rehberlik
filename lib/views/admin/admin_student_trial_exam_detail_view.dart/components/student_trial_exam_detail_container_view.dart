import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../core/widgets/containers/app_list_box_container.dart';
import '../../../../core/widgets/text/app_box_title.dart';
import '../cubit/student_trial_exam_detail_cubit.dart';

class StudentTrialExamDetailContainerView extends StatelessWidget {
  const StudentTrialExamDetailContainerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(
      child: Column(
        children: [
          const AppBoxTitle(isBack: false, title: 'Deneme Sınavları Öğrenci Sonuç Karnesi'),
          BlocBuilder<StudentTrialExamDetailCubit, StudentTrialExamDetailState>(
            builder: (context, state) {
              if (state is StudentTrialExamStudentSelectedStade) {
                return Text('${state.student}');
                debugPrint('selected');
              } else {
                return const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress());
              }
            },
          )
        ],
      ),
    );
  }
}
