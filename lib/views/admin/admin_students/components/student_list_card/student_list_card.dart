part of admin_students_view;

class StudentListBox extends StatelessWidget {
  const StudentListBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppListBoxContainer(child: _getStudentListBox(context));
  }

  Widget _getStudentListBox(BuildContext context) {
    return BlocBuilder<ClassListCubit, ClassListState>(
        builder: (context, classListState) {
      final classesList = classListState.studentWithClassList;
      if (classListState.isLoading) {
        return const SizedBox(
            height: minimumBoxHeight, child: DefaultCircularProgress());
      } else {
        return BlocBuilder<StudentListCubit, StudentListState>(
            builder: (context, state) {
          final selectedIndex =
              state is SelectedIndexState ? state.selectedIndex : 0;
          final String className = classesList != null && classesList.isNotEmpty
              ? classesList[selectedIndex].classes.className ?? ''
              : '';

          final List<Student>? studentList =
              classesList != null && classesList.isNotEmpty
                  ? classesList[selectedIndex].studentList
                  : null;
          if (classesList != null && classesList.isNotEmpty) {
            return Column(children: [
              _getTitle(className),
              const Divider(),
              if (studentList != null && studentList.isNotEmpty)
                _getStudentListView(studentList),
              if (studentList == null || studentList.isEmpty)
                const AppEmptyWarningText(
                    text: LocaleKeys.students_studentListEmptyAlert)
            ]);
          } else {
            return const AppEmptyWarningText(
                text: LocaleKeys.students_classListEmptyAlert);
          }
        });
      }
    });
  }

  Widget _getTitle(String className) {
    return AppBoxTitle(
      title: LocaleKeys.students_className.locale([className]),
    );
  }

  Widget _getStudentListView(List<Student> studentList) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          final student = studentList[index];
          return Container(
            decoration: defaultDividerDecoration,
            child: Material(
              child: InkWell(
                mouseCursor: SystemMouseCursors.click,
                hoverColor: Colors.white10,
                splashColor: bgColor,
                onHover: (isHover) {
                  if (isHover) {
                    //debugPrint("Hover");
                  }
                },
                onTap: () {
                  showStudentDetail(student);
                },
                child: ListTile(
                  // horizontalTitleGap: 0.3,
                  leading: _setStudentLeading(student.photoUrl),
                  title: Text(student.studentName!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400)),
                  subtitle: Text(
                    "No: ${student.studentNumber.toString()}",
                    style: defaultSubtitleStyle,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppSmallRoundedButton(onPressed: () {}),
                      const SizedBox(
                        width: defaultPadding / 2,
                      ),
                      AppSmallRoundedButton(
                          bgColor: Colors.redAccent,
                          iconData: Icons.delete,
                          onPressed: () {})
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _setStudentLeading(String? photoUrl) {
    return photoUrl != null
        ? CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
          )
        : const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          );
  }

  void showStudentDetail(Student student) {
    /*
    if (selectedStudent.value != student) {
      _programController.programList.value = null;
      _timeTableController.timeTableList.value = null;
    }
    selectedStudent.value = student;
    Get.toNamed(Constants.routeStudentDetail);

     */

    final arguments = {"student": student};
    Get.toNamed(Constants.routeStudentDetail, arguments: arguments);
  }
}
