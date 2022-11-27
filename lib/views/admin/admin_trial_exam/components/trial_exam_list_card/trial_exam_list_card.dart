part of admin_trial_exam_view;

class TrialExamListCard extends StatelessWidget {
  const TrialExamListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // _addAllExamResult();
    debugPrint('trialExamListCard');
    return Card(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: minimumBoxHeight),
        child: Padding(
          padding: const EdgeInsets.only(bottom: defaultPadding),
          child: _getTrialExamListBox(),
        ),
      ),
    );
  }

  Widget _getTrialExamListBox() {
    return BlocBuilder<TrialExamListCubit, TrialExamListState>(builder: (context, state) {
      final trialExamList = state.trialExamList;
      final selectedCategory = state.selectedCategory;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: _getTitle(state)),
                if (trialExamList != null && trialExamList.length > 1)
                  _getTotalTrialExamDetailView(context, selectedCategory),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            height: .5,
          ),
          if (state.isLoading) const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress()),
          if (trialExamList != null && !state.isLoading) _getTrialExamListView(trialExamList),
          if (trialExamList != null && trialExamList.isEmpty && !state.isLoading)
            const AppEmptyWarningText(text: LocaleKeys.trialExams_trialExamListEmptyAlert)
        ],
      );
    });
  }

  Widget _getTitle(TrialExamListState state) {
    return AppBoxTitle(
        isBack: false, title: LocaleKeys.trialExams_trialExamListTitle.locale([state.selectedCategory.toString()]));
  }

  Widget _getTrialExamListView(List<TrialExam> trialExamList) {
    //subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trialExamList.length,
        separatorBuilder: (context, index) => defaultDivider,
        itemBuilder: (context, index) {
          final trialExam = trialExamList[index];
          return AppListTile(
            title: trialExam.examName!,
            detailOnPressed: () {
              _goTrialExamDetail(trialExam, context);
            },
            editOnPressed: () {
              context.read<TrialExamFormBoxCubit>().editTrialExam(trialExam: trialExam);
            },
            deleteOnPressed: () {
              _deleteTrialExam(trialExam, context);
            },
            iconData: Icons.insert_chart,
          );
        });
  }

  void _goTrialExamDetail(TrialExam trialExam, BuildContext context) {
    /*
    final trialExamResultController = Get.put(AdminTrialExamResultController());
    if (trialExamResultController.selectedTrialExam != trialExam) {
      trialExamResultController.selectedTrialExam = trialExam;
      trialExamResultController.getAllTrialExamDetail();
    }

    Get.toNamed(Constants.routeTrialExamResult);

     */
    context.router.push(AdminTrialExamResultRoute(trialExam: trialExam));
  }

  void _deleteTrialExam(TrialExam trialExam, BuildContext context) {
    CustomDialog.showDeleteAlertDialog(
        context: context,
        message: LocaleKeys.trialExams_trialExamDeleteAlert.locale([trialExam.examName!]),
        onConfirm: () {
          context.read<TrialExamListCubit>().deleteTrialExam(trialExam: trialExam).then((value) {
            CustomDialog.showSnackBar(
              message: LocaleKeys.alerts_delete_success.locale(['Deneme Sınavı']),
              context: context,
              type: DialogType.success,
            );
          }, onError: (e) {
            CustomDialog.showSnackBar(
              message: LocaleKeys.alerts_error.locale([e.toString()]),
              context: context,
              type: DialogType.error,
            );
          });
        });
  }

  _getTotalTrialExamDetailView(BuildContext context, int selectedCategory) {
    return ElevatedButton.icon(
        onPressed: () {
          context.router.replace(AdminTrialExamTotalRoute(classLevel: selectedCategory));
        },
        icon: const Icon(Icons.query_stats),
        label: const Text('Ortalama '
            'Sonuçlar'));
  }
}
