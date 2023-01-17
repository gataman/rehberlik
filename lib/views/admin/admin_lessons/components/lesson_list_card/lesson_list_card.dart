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

        return Column(children: [
          _getTitle(state),
          const Divider(),
          if (state.isLoading) const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress()),
          if (lessonList == null && !state.isLoading)
            const AppEmptyWarningText(text: LocaleKeys.lessons_lessonListEmptyAlert),
          if (lessonList != null && lessonList[state.selectedCategory] == null && !state.isLoading)
            const AppEmptyWarningText(text: LocaleKeys.lessons_lessonListEmptyAlert),
          if (lessonList != null && !state.isLoading) _getLessonListView(lessonList[state.selectedCategory]!),
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

  ListView _getLessonListView(List<LessonWithSubject> lessonList) {
    lessonList.sort((a, b) => b.lesson.lessonTime!.compareTo(a.lesson.lessonTime!));
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lessonList.length,
      separatorBuilder: (context, index) => defaultDivider,
      itemBuilder: (context, index) {
        final lessonWithSubject = lessonList[index];
        return AppListTile(
          iconData: Icons.menu_book,
          title: lessonWithSubject.lesson.lessonName!,
          detailOnPressed: () {
            _goSubjectsPage(lessonWithSubject, context);
          },
          editOnPressed: () {
            context.read<LessonFormBoxCubit>().editLesson(lesson: lessonWithSubject.lesson);
          },
          deleteOnPressed: () {
            _deleteLesson(lessonWithSubject, context);
          },
        );
      },
    );
  }

  void _goSubjectsPage(LessonWithSubject lessonWithSubject, BuildContext context) {
    context.router.navigate(AdminSubjectsRoute(lessonWithSubject: lessonWithSubject));
    //Get.toNamed(AdminRoutes.routeSubjects, parameters: params);
    //Navigator.pushNamed(context, AdminRoutes.routeSubjects,)
  }

  void _deleteLesson(LessonWithSubject lessonWithSubject, BuildContext context) {
    CustomDialog.showDeleteAlertDialog(
        context: context,
        message: LocaleKeys.lessons_lessonDeleteAlert.locale([lessonWithSubject.lesson.lessonName!]),
        onConfirm: () {
          context.read<LessonListCubit>().deleteLesson(lessonWithSubject: lessonWithSubject).then((value) {
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
