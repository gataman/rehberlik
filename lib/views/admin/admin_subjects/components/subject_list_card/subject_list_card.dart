part of admin_subjects_view;

class SubjectListCard extends StatelessWidget {
  const SubjectListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final params = Get.parameters;
    return BlocBuilder<SubjectListCubit, SubjectListState>(
        builder: (cubit, state) {
      return Container(
        decoration: defaultBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.only(bottom: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state is SubjectListLoadingState)
                const SizedBox(height: 250, child: DefaultCircularProgress()),
              if (state is SubjectListLoadedState)
                AppBoxTitle(title: "${params['lessonName']} Dersi Konuları"),
              if (state is SubjectListLoadedState &&
                  state.subjectList.isNotEmpty)
                _getSubjectListBox(state.subjectList),
              if (state is SubjectListLoadedState && state.subjectList.isEmpty)
                const AppEmptyWarningText(
                    text:
                        "Bu derse henüz konu eklenmemiş. Lütfen konu ekleyiniz!")
            ],
          ),
        ),
      );
    });
  }

  Widget _getSubjectListBox(List<Subject> subjectList) {
    subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: subjectList.length,
        itemBuilder: (context, index) {
          final subject = subjectList[index];
          return AppListTile(
            title: subject.subject!,
            iconData: Icons.book,
            editOnPressed: () {
              context.read<EditSubjectCubit>().editSubject(subject);
            },
            deleteOnPressed: () {
              _deleteSubject(subject: subject, index: index, context: context);
            },
          );
        });
  }

  void _deleteSubject(
      {required Subject subject,
      required int index,
      required BuildContext context}) {
    Get.defaultDialog(
      title: "Uyarı",
      middleText:
          "${subject.subject} adlı konuyu silmek istediğinizden emin misiniz?",
      contentPadding: const EdgeInsets.all(defaultPadding),
      onConfirm: () {
        context.read<SubjectListCubit>().deleteSubject(subject);

        Get.back();
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }
}
