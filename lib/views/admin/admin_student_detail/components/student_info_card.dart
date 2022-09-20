part of admin_student_detail_view;

class StudentInfoCard extends StatelessWidget {
  final Student? student;

  StudentInfoCard({Key? key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(context.toString());
    var pdfBuilder = StudentDetailPdfBuilder(context);
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
                    student!.studentName.toString(),
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
                        child: SizedBox(height: 80, width: 80, child: _setStudentProfileImage(student!.photoUrl)),
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
                        value: "",
                      ),
                      buildRow(
                        label: "Sınıfı",
                        value: student!.className ?? '',
                      ),
                      buildRow(
                        label: "Numarası",
                        value: student!.studentNumber ?? '',
                      ),
                      buildRow(
                        label: "Baba Adı",
                        value: student!.fatherName ?? '',
                      ),
                      buildRow(
                        label: "Anne Adı",
                        value: student!.motherName ?? '',
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
                        text: 'Çalışma Programı İndir',
                        textColor: darkSecondaryColor,
                        iconData: Icons.download,
                        loadingListener: pdfBuilder.notifier,
                        onPressed: () {
                          pdfBuilder.build(student!);
                        })),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
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
