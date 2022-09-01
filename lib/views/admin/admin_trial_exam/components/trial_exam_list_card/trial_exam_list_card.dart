part of admin_trial_exam_view;

class TrialExamListCard extends StatelessWidget {
  const TrialExamListCard({Key? key}) : super(key: key);

/*
  void _addAllExamResult() {
    final list = <TrialExamResult>[
      TrialExamResult(
        studentID: 'H58WRsRv7hpUy5uE9oug',
        studentName: 'AYÇA DEMİRCİ',
        studentNumber: '35',
        className: '5-A',
        examID: 'B5EQS4PcjcQnWnSwqXwm',
        turDog: 1,
        turYan: 2,
        turNet: 1.2,
        matDog: 3,
        matYan: 4,
        matNet: 3.2,
        fenDog: 5,
        fenYan: 6,
        fenNet: 5.2,
        sosDog: 7,
        sosYan: 8,
        sosNet: 7.2,
        ingDog: 9,
        ingYan: 10,
        ingNet: 9.2,
        dinDog: 11,
        dinYan: 12,
        dinNet: 11.2,
      )
    ];

    controller.addAllTrialExamResult(resultList: list);
  }

 */
  @override
  Widget build(BuildContext context) {
    // _addAllExamResult();
    return Container(
      decoration: defaultBoxDecoration,
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
    return BlocBuilder<TrialExamListCubit, TrialExamListState>(
        builder: (context, state) {
      final trialExamList = state.trialExamList;
      return Column(
        children: [
          _getTitle(state),
          if (state.isLoading)
            const SizedBox(
                height: minimumBoxHeight, child: DefaultCircularProgress()),
          if (trialExamList != null && !state.isLoading)
            _getTrialExamListView(trialExamList),
          if (trialExamList != null &&
              trialExamList.isEmpty &&
              !state.isLoading)
            const AppEmptyWarningText(
                text: LocaleKeys.trialExams_trialExamListEmptyAlert)
        ],
      );
    });
  }

  Widget _getTitle(TrialExamListState state) {
    return AppBoxTitle(
        title: LocaleKeys.trialExams_trialExamListTitle
            .locale([state.selectedCategory.toString()]));
  }

  Widget _getTrialExamListView(List<TrialExam> trialExamList) {
    //subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trialExamList.length,
        itemBuilder: (context, index) {
          final trialExam = trialExamList[index];
          return AppListTile(
            title: trialExam.examName!,
            detailOnPressed: () {
              _goTrialExamDetail(trialExam);
            },
            editOnPressed: () {
              context
                  .read<TrialExamFormBoxCubit>()
                  .editTrialExam(trialExam: trialExam);
            },
            deleteOnPressed: () {
              _deleteTrialExam(trialExam, context);
            },
            iconData: Icons.insert_chart,
          );
        });
  }

  void _goTrialExamDetail(TrialExam trialExam) {
    final trialExamResultController = Get.put(AdminTrialExamResultController());
    if (trialExamResultController.selectedTrialExam != trialExam) {
      trialExamResultController.selectedTrialExam = trialExam;
      trialExamResultController.getAllTrialExamDetail();
    }

    Get.toNamed(Constants.routeTrialExamResult);
  }

  void _deleteTrialExam(TrialExam trialExam, BuildContext context) {
    CustomDialog.showDeleteAlertDialog(
        message: LocaleKeys.trialExams_trialExamDeleteAlert
            .locale([trialExam.examName!]),
        onConfirm: () {
          context
              .read<TrialExamListCubit>()
              .deleteTrialExam(trialExam: trialExam)
              .then((value) {
            Get.back();
          }, onError: (e) {
            CustomDialog.showErrorMessage(
                message: LocaleKeys.alerts_error.locale([e.toString()]));
          });
        });
  }
}
