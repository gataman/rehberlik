part of admin_trial_exam_result_view;

class TrialExamResultUploads extends StatelessWidget {
  const TrialExamResultUploads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Text(
              "Deneme Sonucu Yükle",
              style: defaultTitleStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ButtonWithIcon(
              labelText: "Excel Sonuç Yükle",
              icon: Icons.upload,
              onPressed: () {
                //Get.toNamed(Constants.routeTrialExamExcelImport);
              },
            ),
          ),
        ],
      ),
    );
  }
}
