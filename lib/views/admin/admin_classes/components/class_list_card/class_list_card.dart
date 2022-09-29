part of admin_classes_view;

class ClassListCard extends StatelessWidget {
  const ClassListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(child: _getClassesListBox());
  }

  Widget _getClassesListBox() {
    return BlocBuilder<ClassListCubit, ClassListState>(
      builder: (context, state) {
        return Column(children: [
          _getTitle(state),
          const Divider(),
          if (state is ClassListLoadingState)
            const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress()),
          if (state is ClassListLoadedState) _getClassesListView(state),
        ]);
      },
    );
  }

  Widget _getTitle(ClassListState state) {
    return AppBoxTitle(
      isBack: false,
      title: LocaleKeys.classes_classListBoxTitle.locale(),
    );
  }

  Widget _getClassesListView(ClassListLoadedState state) {
    if (state.studentWithClassList != null && state.studentWithClassList!.isNotEmpty) {
      final classesList = state.studentWithClassList!;
      return SizedBox(
        height: defaultListHeight,
        child: ListView.separated(
            itemCount: classesList.length,
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemBuilder: (context, index) {
              final classes = classesList[index].classes;
              return SizedBox(
                child: AppListTile(
                  svgData: "${iconsSrc}menu_classroom.svg",
                  title: classes.className ?? '',
                  detailOnPressed: () {
                    _showClassDetail(context: context, index: index);
                  },
                  editOnPressed: () {
                    context.read<ClassFormBoxCubit>().editClass(classes: classes);
                  },
                  deleteOnPressed: () {
                    _deleteClass(classes, context);
                  },
                ),
              );
            }),
      );
    } else {
      return const AppEmptyWarningText(text: LocaleKeys.classes_classListEmptyAlert);
    }
  }

  void _deleteClass(Classes classes, BuildContext context) {
    CustomDialog.showDeleteAlertDialog(
        context: context,
        message: LocaleKeys.classes_classDeleteAlert.locale([classes.className!]),
        onConfirm: () {
          context.read<ClassListCubit>().deleteClass(classes).then((value) {
            CustomDialog.showSnackBar(
              message: LocaleKeys.alerts_delete_success.locale(['Sınıf']),
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

  void _showClassDetail({required BuildContext context, required int index}) {
    //selectedIndex.value = index;
    context.read<StudentListCubit>().selectClass(selectedIndex: index);
    context.router.replaceNamed(AppRoutes.routeAdminStudents);
  }
}
