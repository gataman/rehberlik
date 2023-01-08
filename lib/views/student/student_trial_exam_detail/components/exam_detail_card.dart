import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/core/widgets/text/app_box_title.dart';
import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/models/trial_exam_class_result.dart';
import 'package:rehberlik/models/trial_exam_result.dart';

import '../../../../common/constants.dart';
import '../../../admin/admin_student_trial_exam_detail_view/cubit/student_trial_exam_detail_cubit.dart';
import 'student_exam_result_detail_card.dart';
import 'trial_exam_detail_helper.dart';

class ExamDetailCard extends StatelessWidget {
  const ExamDetailCard({Key? key, required this.trialExam}) : super(key: key);
  final TrialExam trialExam;

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
              _getTrialExamDetailBox(),
            ],
          ),
        ),
      ),
    );
  }

  _getTitle(BuildContext context) {
    return AppBoxTitle(title: '${trialExam.examName} Sınavı Sonucu', isBack: true);
  }

  _getTrialExamDetailBox() {
    return BlocBuilder<StudentTrialExamDetailCubit, StudentTrialExamDetailState>(
      builder: (context, state) {
        if (state is StudentTrialExamStudentSelectedStade) {
          //final examDetail = _findTrialExamDetail(state.studentTrialExamResultList);
          return FutureBuilder<TrialExamResult?>(
            future: _findTrialExamDetail(state.studentTrialExamResultList),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                TrialExamResult? examDetail = snapshot.data;
                if (examDetail != null) {
                  return StudentExamResultDetailCard(
                      trialExamResult: examDetail, trialExamClassResultList: state.trialExamClassResult);
                } else {
                  return _emptyMessage();
                }
              } else {
                return _emptyMessage();
              }
            },
          );
        } else {
          return const Text('...');
        }
      },
    );
  }

  SizedBox _emptyMessage() {
    return const SizedBox(
      height: minimumBoxHeight,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Text(
            'Öğrenci bu sınava girmemiş veya sonuç eklenmemiş görünüyor. Bir hata olduğunu düşünüyorsanız rehberlik öğretmeninize danışınız!'),
      ),
    );
  }

  Future<TrialExamResult?> _findTrialExamDetail(List<TrialExamResult>? studentTrialExamResultList) async {
    if (studentTrialExamResultList != null) {
      final exam = studentTrialExamResultList.findOrNull((element) => element.examID!.contains(trialExam.id!));
      return exam;
    }
    return null;
  }
}
