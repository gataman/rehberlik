part of admin_student_detail_view;

class StudentInfoCard extends GetView<AdminStudentDetailController> {
  StudentInfoCard({Key? key}) : super(key: key);
  final pdfBuilder = Get.put(StudentDetailPdfBuilder());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final student = controller.studentController.selectedStudent.value;
      if (student != null) {
        return Column(
          children: [
            Container(
              decoration: defaultBoxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Text(
                      student.studentName.toString(),
                      textAlign: TextAlign.center,
                      style: defaultTitleStyle,
                    ),
                  ),
                  Container(
                    color: Colors.amber,
                    child: Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding / 3),
                          child: SizedBox(
                              height: 80,
                              width: 80,
                              child: _setStudentProfileImage(student.photoUrl)),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: Table(
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      children: [
                        buildRow(
                          label: "T.C. Kimlik No",
                          value: "123456789",
                        ),
                        buildRow(
                          label: "Sınıfı",
                          value: student.className.toString(),
                        ),
                        buildRow(
                          label: "Numarası",
                          value: student.studentNumber.toString(),
                        ),
                        buildRow(
                          label: "Baba Adı",
                          value: student.fatherName.toString(),
                        ),
                        buildRow(
                          label: "Anne Adı",
                          value: student.motherName.toString(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              decoration: defaultBoxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Text(
                      "Raporlar",
                      style: defaultTitleStyle,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: LoadingButton(
                          text: "Pdf Oluştur",
                          textColor: secondaryColor,
                          iconData: Icons.download,
                          loadingListener: pdfBuilder.notifier,
                          onPressed: () {
                            pdfBuilder.build(student);
                          })),
                ],
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  TableRow buildRow({required String label, required String value}) {
    return TableRow(
      children: [
        SizedBox(
          height: 30,
          child: Text(
            label,
            style: defaultInfoTitle,
          ),
        ),
        const Text(
          ":",
          style: defaultInfoTitle,
        ),
        Text(value),
      ],
    );
  }

  Widget _setStudentProfileImage(String? photoUrl) {
    return photoUrl != null
        ? CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
          )
        : const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          );
  }
}
