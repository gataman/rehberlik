part of admin_trial_exam_view;

class TrialExamListBox extends GetView<AdminTrialExamController> {
  const TrialExamListBox({Key? key}) : super(key: key);
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
    return Obx(() {
      final trialExamList = controller.trialExamList.value;
      final selectedClassLevel = controller.selectedClassLevel;

      return Container(
        decoration: defaultBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (trialExamList == null)
                const SizedBox(height: 250, child: DefaultCircularProgress()),
              if (trialExamList != null)
                GestureDetector(
                  onTap: () {
                    Get.back(id: 1);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${selectedClassLevel.toString()}. Sınıf Deneme Listesi",
                          style: defaultTitleStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              if (trialExamList != null && trialExamList.isNotEmpty)
                _getTrialExamListBox(trialExamList),
              if (trialExamList != null && trialExamList.isEmpty)
                const SizedBox(
                  height: 250,
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Text(
                        "Bu derse henüz konu eklenmemiş. Lütfen konu ekleyiniz!"),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _getTrialExamListBox(List<TrialExam> trialExamList) {
    //subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trialExamList.length,
        itemBuilder: (context, index) {
          final trialExam = trialExamList[index];
          return Container(
            decoration: defaultDividerDecoration,
            child: GestureDetector(
              onTap: () {
                final trialExamResultController =
                    Get.put(AdminTrialExamResultController());
                if (trialExamResultController.selectedTrialExam != trialExam) {
                  trialExamResultController.selectedTrialExam = trialExam;
                  trialExamResultController.getAllTrialExamDetail();
                }

                Get.toNamed(Constants.routeTrialExamResult);
              },
              child: ListTile(
                  horizontalTitleGap: 0.2,
                  leading: const Icon(
                    Icons.insert_chart,
                    size: 24,
                    color: infoColor,
                  ),
                  title: Text(trialExam.examName!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomRoundedButton(
                        onPressed: () {
                          controller.editingTrialExam.value = trialExam;
                        },
                      ),
                      const SizedBox(width: 16),
                      CustomRoundedButton(
                        bgColor: Colors.redAccent,
                        iconData: Icons.delete,
                        onPressed: () {
                          //_deleteSubject(subject: subject, index: index);
                        },
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}
