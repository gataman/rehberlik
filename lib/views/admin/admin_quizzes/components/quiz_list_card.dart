import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/views/admin/admin_quizzes/cubit/quiz_list_cubit.dart';

import '../../../../common/constants.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../core/widgets/list_tiles/app_liste_tile.dart';
import '../../../../core/widgets/text/app_box_title.dart';
import '../../../../core/widgets/text/app_empty_warning_text.dart';
import '../../../../models/quiz.dart';

class QuizListCard extends StatelessWidget {
  const QuizListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // _addAllExamResult();
    return Card(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: minimumBoxHeight),
        child: Padding(
          padding: const EdgeInsets.only(bottom: defaultPadding),
          child: _getQuizListBox(),
        ),
      ),
    );
  }

  Widget _getQuizListBox() {
    return BlocBuilder<QuizListCubit, QuizListState>(builder: (context, state) {
      List<Quiz> quizList = <Quiz>[];
      if (state is QuizListLoadedState && state.quizList != null) {
        quizList = state.quizList!;
      } else {
        quizList = context.read<QuizListCubit>().quizList;
      }

      return Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: _getTitle()),
          const Divider(
            thickness: 1,
            height: .5,
          ),
          if (state is QuizListLoadingState) const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress()),
          _getTrialExamListView(quizList),
          if (state is! QuizListLoadingState && quizList.isEmpty)
            const AppEmptyWarningText(text: 'Sınav eklenmemiş lütfen öncelikle sınav ekleyiniz!')
        ],
      );
    });
  }

  Widget _getTitle() {
    return const AppBoxTitle(isBack: false, title: 'Sınav Listesi');
  }

  Widget _getTrialExamListView(List<Quiz> quizList) {
    //subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: quizList.length,
        separatorBuilder: (context, index) => defaultDivider,
        itemBuilder: (context, index) {
          final quiz = quizList[index];
          return AppListTile(
            title: quiz.quizTitle!,
            detailOnPressed: () {
              //_goTrialExamDetail(trialExam, context);
            },
            editOnPressed: () {
              //context.read<TrialExamFormBoxCubit>().editTrialExam(trialExam: trialExam);
            },
            deleteOnPressed: () {
              //_deleteTrialExam(trialExam, context);
            },
            iconData: Icons.insert_chart,
          );
        });
  }

  // void _goTrialExamDetail(Quiz quiz, BuildContext context) {
  //   /*
  //   final trialExamResultController = Get.put(AdminTrialExamResultController());
  //   if (trialExamResultController.selectedTrialExam != trialExam) {
  //     trialExamResultController.selectedTrialExam = trialExam;
  //     trialExamResultController.getAllTrialExamDetail();
  //   }

  //   Get.toNamed(Constants.routeTrialExamResult);

  //    */
  //   //context.router.push(AdminTrialExamResultRoute(trialExam: trialExam));
  // }

  // void _deleteTrialExam(Quiz quiz, BuildContext context) {
  //   CustomDialog.showDeleteAlertDialog(
  //       context: context,
  //       message: '${quiz.quizTitle} adlı sınavı silmek istediğinizden emin misiniz?',
  //       onConfirm: () {
  //         context.read<QuizListCubit>().deleteQuiz(quiz: quiz).then((value) {
  //           CustomDialog.showSnackBar(
  //             message: LocaleKeys.alerts_delete_success.locale(['Sınav']),
  //             context: context,
  //             type: DialogType.success,
  //           );
  //         }, onError: (e) {
  //           CustomDialog.showSnackBar(
  //             message: LocaleKeys.alerts_error.locale([e.toString()]),
  //             context: context,
  //             type: DialogType.error,
  //           );
  //         });
  //       });
  // }
}
