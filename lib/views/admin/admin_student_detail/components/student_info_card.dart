part of admin_student_detail_view;

class StudentInfoCard extends StatelessWidget {
  final Student? student;

  StudentInfoCard({Key? key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pdfBuilder = StudentDetailPdfBuilder(context);
    if (student != null) {
      return Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Text(
                    student!.studentName.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
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
                      buildRow(label: "T.C. Kimlik No", value: "", context: context),
                      buildRow(label: "Sınıfı", value: student!.className ?? '', context: context),
                      buildRow(label: "Numarası", value: student!.studentNumber ?? '', context: context),
                      buildRow(label: "Baba Adı", value: student!.fatherName ?? '', context: context),
                      buildRow(
                        label: "Anne Adı",
                        value: student!.motherName ?? '',
                        context: context,
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
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: AppBoxTitle(
                    title: 'Raporlar',
                    isBack: false,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: LoadingButton(
                        text: 'Çalışma Programı İndir',
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

  TableRow buildRow({required String label, required String value, required BuildContext context}) {
    return TableRow(
      children: [
        SizedBox(
          height: 30,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Text(
          ":",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
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
