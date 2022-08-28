part of admin_subjects_view;

class SubjectListBox extends GetView<AdminSubjectsController> {
  const SubjectListBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final params = Get.parameters;
    if (params['lessonID'] == null) {
      return Container(
        child: Text('Bir hata oluştu!'),
      );
    } else {
      _getSubjectList(lessonID: params['lessonID']!);
      return Obx(() {
        final subjectList = controller.subjectList.value;
        debugPrint("Obx SubjectList ${subjectList.toString()} ");

        return Container(
          decoration: defaultBoxDecoration,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (subjectList == null)
                  const SizedBox(height: 250, child: DefaultCircularProgress()),
                if (subjectList != null)
                  Text(
                    "${params['lessonName']} Dersi Konuları",
                    style: defaultTitleStyle,
                  ),
                if (subjectList != null && subjectList.isNotEmpty)
                  _getSubjectListBox(subjectList),
                if (subjectList != null && subjectList.isEmpty)
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
  }

  void _getSubjectList({required String lessonID}) {
    controller.getAllSubjectList(lessonID: lessonID);
  }

  Widget _getSubjectListBox(List<Subject> subjectList) {
    subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: subjectList.length,
        itemBuilder: (context, index) {
          final subject = subjectList[index];
          return Container(
            decoration: defaultDividerDecoration,
            child: GestureDetector(
              onTap: () {},
              child: ListTile(
                  horizontalTitleGap: 0.2,
                  leading: const Icon(
                    Icons.book,
                    size: 24,
                    color: infoColor,
                  ),
                  title: Text(subject.subject!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomRoundedButton(
                        onPressed: () {
                          controller.editingSubject.value = subject;
                        },
                      ),
                      const SizedBox(width: 16),
                      CustomRoundedButton(
                        bgColor: Colors.redAccent,
                        iconData: Icons.delete,
                        onPressed: () {
                          _deleteSubject(subject: subject, index: index);
                        },
                      ),
                    ],
                  )),
            ),
          );
        });
  }

  void _deleteSubject({required Subject subject, required int index}) {
    Get.defaultDialog(
      title: "Uyarı",
      middleText:
          "${subject.subject} adlı konuyu silmek istediğinizden emin misiniz?",
      contentPadding: const EdgeInsets.all(defaultPadding),
      onConfirm: () {
        controller.deleteSubject(subject).then((value) {
          controller.subjectList.value!.remove(subject);
          controller.subjectList.refresh();
          controller.editingSubject.value = null;
        });

        Get.back();
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }
}
