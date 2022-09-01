part of admin_classes_view;

class ClassListCard extends GetView<AdminClassesController> {
  const ClassListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppListBoxContainer(child: _getClassesListBox());
  }

  Widget _getClassesListBox() {
    return BlocBuilder<ClassListCubit, ClassListState>(
      builder: (context, state) {
        debugPrint("Classes List builder çalıştı...............");
        final studentWithClassList = state.studentWithClassList;
        return Column(children: [
          _getTitle(state),
          const Divider(),
          if (state.isLoading)
            const SizedBox(
                height: minimumBoxHeight, child: DefaultCircularProgress()),
          if (studentWithClassList != null && !state.isLoading)
            _getClassesListView(studentWithClassList),
          if (studentWithClassList == null && !state.isLoading)
            const AppEmptyWarningText(
                text: LocaleKeys.classes_classListEmptyAlert)
        ]);
      },
    );
  }

  Widget _getTitle(ClassListState state) {
    return AppBoxTitle(
      title: LocaleKeys.classes_classListBoxTitle.locale(),
    );
  }

  ListView _getClassesListView(List<StudentWithClass> classesList) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: classesList.length,
        itemBuilder: (context, index) {
          final classes = classesList[index].classes;
          return AppListTile(
            svgData: "${iconsSrc}menu_classroom.svg",
            title: classes.className ?? '',
            detailOnPressed: () {
              _showClassDetail(context: context, index: index);
            },
            editOnPressed: () {},
            deleteOnPressed: () {
              _deleteClass(classes);
            },
          );
        });
  }

  void _deleteClass(Classes classes) {
    Get.defaultDialog(
      title: "Uyarı",
      middleText:
          "${classes.className} adlı sınıfı silmek istediğinizden emin misiniz?",
      contentPadding: const EdgeInsets.all(defaultPadding),
      onConfirm: () {
        controller.deleteClass(classes);
        Get.back();
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }

  void _showClassDetail({required BuildContext context, required int index}) {
    //selectedIndex.value = index;
    context.read<StudentListCubit>().selectIndex(selectedIndex: index);
    Get.toNamed(Constants.routeStudents);
  }
}
