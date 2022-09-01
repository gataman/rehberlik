part of admin_lessons_view;

class LessonListCard extends StatelessWidget {
  LessonListCard({Key? key}) : super(key: key);
  final ValueNotifier<bool> deleteButtonListener = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: defaultBoxDecoration,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: minimumBoxHeight),
          child: Padding(
              padding: const EdgeInsets.only(bottom: defaultPadding),
              child: _getLessonListBox()),
        ));
  }

  Widget _getLessonListBox() {
    return BlocBuilder<LessonListCubit, LessonListState>(
      builder: (context, state) {
        debugPrint("LessonList builder çalıştı...............");
        final lessonList = state.lessonList;
        if (lessonList != null) {
          lessonList.sort((a, b) => b.lessonTime!.compareTo(a.lessonTime!));
        }
        return Column(children: [
          _getTitle(state),
          const Divider(),
          if (state.isLoading)
            const SizedBox(
                height: minimumBoxHeight, child: DefaultCircularProgress()),
          if (lessonList != null && !state.isLoading)
            _getLessonListView(lessonList),
          if (lessonList == null && !state.isLoading)
            const AppEmptyWarningText(
                text: LocaleKeys.lessons_lessonListEmptyAlert)
        ]);
      },
    );
  }

  Widget _getTitle(LessonListState state) {
    return AppBoxTitle(
      title: LocaleKeys.lessons_lessonListTitle
          .locale([state.selectedCategory.toString()]),
    );
  }

  ListView _getLessonListView(List<Lesson> lessonList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lessonList.length,
      itemBuilder: (context, index) {
        final lesson = lessonList[index];
        return AppListTile(
          iconData: Icons.menu_book,
          title: lesson.lessonName!,
          detailOnPressed: () {
            _goSubjectsPage(lesson);
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

  void _goSubjectsPage(Lesson lesson) {
    final params = {'lessonID': lesson.id!, 'lessonName': lesson.lessonName!};
    Get.toNamed(AdminRoutes.routeSubjects, parameters: params);
    //Navigator.pushNamed(context, AdminRoutes.routeSubjects,)
  }

  void _deleteLesson(Lesson lesson, BuildContext context) {
    CustomDialog.showDeleteAlertDialog(
        message:
            LocaleKeys.lessons_lessonDeleteAlert.locale([lesson.lessonName!]),
        onConfirm: () {
          context.read<LessonListCubit>().deleteLesson(lesson: lesson).then(
              (value) {
            Get.back();
          }, onError: (e) {
            CustomDialog.showErrorMessage(
                message: LocaleKeys.alerts_error.locale([e.toString()]));
          });
        });
  }
}
