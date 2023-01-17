part of admin_subjects_view;

class SubjectListCard extends StatelessWidget {
  final String lessonName;

  const SubjectListCard({Key? key, required this.lessonName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectListCubit, SubjectListState>(builder: (cubit, state) {
      return AppBoxContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state is SubjectListLoadingState) const SizedBox(height: 250, child: DefaultCircularProgress()),
            if (state is SubjectListLoadedState) AppBoxTitle(isBack: true, title: lessonName),
            if (state is SubjectListLoadedState && state.subjectList.isNotEmpty) _getSubjectListBox(state.subjectList),
            if (state is SubjectListLoadedState && state.subjectList.isEmpty)
              const AppEmptyWarningText(text: "Bu derse henüz konu eklenmemiş. Lütfen konu ekleyiniz!")
          ],
        ),
      );
    });
  }

  Widget _getSubjectListBox(List<Subject> subjectList) {
    subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: subjectList.length,
        separatorBuilder: (context, index) => defaultDivider,
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

  // Widget _getSubjectListBox(List<Subject> subjectList) {
  //   subjectList.sort((a, b) => a.subject!.compareTo(b.subject!));
  //   return ReorderableListView.builder(
  //     itemBuilder: (context, index) {
  //       final subject = subjectList[index];
  //       return AppListTile(
  //         key: ValueKey(subject),
  //         title: subject.subject!,
  //         iconData: Icons.book,
  //         editOnPressed: () {
  //           context.read<EditSubjectCubit>().editSubject(subject);
  //         },
  //         deleteOnPressed: () {
  //           _deleteSubject(subject: subject, index: index, context: context);
  //         },
  //       );
  //     },
  //     shrinkWrap: true,
  //     itemCount: subjectList.length,
  //     onReorder: (oldIndex, newIndex) {
  //       debugPrint('OldIndex : $oldIndex');
  //       debugPrint('NewIndex : $newIndex');
  //     },
  //   );
  // }

  void _deleteSubject({required Subject subject, required int index, required BuildContext context}) {
    CustomDialog.showDeleteAlertDialog(
        context: context,
        message: "${subject.subject} adlı konuyu silmek istediğinizden emin misiniz?",
        onConfirm: () {
          context.read<SubjectListCubit>().deleteSubject(subject).then((value) {
            CustomDialog.showSnackBar(
              message: LocaleKeys.alerts_delete_success.locale(['Konu']),
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
}
