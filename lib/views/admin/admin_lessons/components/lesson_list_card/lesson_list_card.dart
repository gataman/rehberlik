part of admin_lessons_view;

class LessonListCard extends StatelessWidget {
  LessonListCard({Key? key}) : super(key: key);
  final ValueNotifier<bool> deleteButtonListener = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: minimumBoxHeight),
      child: Padding(padding: const EdgeInsets.only(bottom: defaultPadding), child: _getLessonListBox()),
    ));
  }

  Widget _getLessonListBox() {
    return BlocBuilder<LessonListCubit, LessonListState>(
      builder: (context, state) {
        final lessonList = state.lessonList;
        if (lessonList != null) {
          lessonList.sort((a, b) => b.lessonTime!.compareTo(a.lessonTime!));
        }
        return Column(children: [
          _getTitle(state),
          const Divider(),
          if (state.isLoading) const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress()),
          if (lessonList != null && !state.isLoading) _getLessonListView(lessonList),
          if (lessonList == null && !state.isLoading)
            const AppEmptyWarningText(text: LocaleKeys.lessons_lessonListEmptyAlert)
        ]);
      },
    );
  }

  Widget _getTitle(LessonListState state) {
    return AppBoxTitle(
      isBack: false,
      title: LocaleKeys.lessons_lessonListTitle.locale([state.selectedCategory.toString()]),
    );
  }

  ListView _getLessonListView(List<Lesson> lessonList) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lessonList.length,
      separatorBuilder: (context, index) => defaultDivider,
      itemBuilder: (context, index) {
        final lesson = lessonList[index];
        return AppListTile(
          iconData: Icons.menu_book,
          title: lesson.lessonName!,
          detailOnPressed: () {
            _goSubjectsPage(lesson, context);
          },
          editOnPressed: () {
            context.read<LessonFormBoxCubit>().editLesson(lesson: lesson);
          },
          deleteOnPressed: () {
            _deleteLesson(lesson, context);
          },
        );
      },
    );
  }

  void _goSubjectsPage(Lesson lesson, BuildContext context) {
    final params = {'lessonID': lesson.id!, 'lessonName': lesson.lessonName!};
    context.router.navigate(AdminSubjectsRoute(lesson: lesson));
    //Get.toNamed(AdminRoutes.routeSubjects, parameters: params);
    //Navigator.pushNamed(context, AdminRoutes.routeSubjects,)
  }

  void _deleteLesson(Lesson lesson, BuildContext context) {
    CustomDialog.showDeleteAlertDialog(
        context: context,
        message: LocaleKeys.lessons_lessonDeleteAlert.locale([lesson.lessonName!]),
        onConfirm: () {
          context.read<LessonListCubit>().deleteLesson(lesson: lesson).then((value) {
            CustomDialog.showSnackBar(
              message: LocaleKeys.alerts_delete_success.locale(['Ders']),
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
