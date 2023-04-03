import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/init/extensions.dart';

import '../../../../common/constants.dart';
import '../../../../common/custom_dialog.dart';
import '../../../../common/navigaton/app_router/app_router.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../core/init/locale_keys.g.dart';
import '../../../../core/widgets/buttons/app_small_rounded_button.dart';
import '../../../../core/widgets/containers/app_list_box_container.dart';
import '../../../../core/widgets/text/app_box_title.dart';
import '../../../../core/widgets/text/app_empty_warning_text.dart';
import '../../../../models/student.dart';
import '../../admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import '../../admin_students/components/student_list_card/cubit/student_list_cubit.dart';

class StudentPasswordListCard extends StatefulWidget {
  const StudentPasswordListCard({Key? key}) : super(key: key);

  @override
  State<StudentPasswordListCard> createState() => _StudentPasswordListCardState();
}

class _StudentPasswordListCardState extends State<StudentPasswordListCard> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(child: _getStudentListBox(context));
  }

  Widget _getStudentListBox(BuildContext context) {
    return BlocBuilder<ClassListCubit, ClassListState>(builder: (context, classListState) {
      if (classListState is ClassListLoadedState) {
        final classesList = classListState.studentWithClassList;
        return BlocBuilder<StudentListCubit, StudentListState>(builder: (context, state) {
          final selectedIndex = state is SelectedIndexState ? state.classIndex : 0;
          final String className =
              classesList != null && classesList.isNotEmpty ? classesList[selectedIndex].classes.className ?? '' : '';

          final List<Student>? studentList =
              classesList != null && classesList.isNotEmpty ? classesList[selectedIndex].studentList : null;
          if (classesList != null && classesList.isNotEmpty) {
            return Column(children: [
              _getTitle(className),
              ListTile(
                // horizontalTitleGap: 0.3,
                leading: const Text(''),

                title: Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Öğrenci Bilgileri',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Text(
                        _showPassword ? 'Şifreyi Gizle' : 'Şifreyi Göster',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                trailing: Text('İşlemler', style: Theme.of(context).textTheme.labelLarge),
              ),
              const Divider(),
              if (studentList != null && studentList.isNotEmpty) _getStudentListView(studentList, context),
              if (studentList == null || studentList.isEmpty)
                const AppEmptyWarningText(text: LocaleKeys.students_studentListEmptyAlert)
            ]);
          } else {
            return const AppEmptyWarningText(text: LocaleKeys.students_classListEmptyAlert);
          }
        });
      } else {
        return const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress());
      }
    });
  }

  Widget _getTitle(String className) {
    return AppBoxTitle(
      isBack: false,
      title: LocaleKeys.students_className.locale([className]),
    );
  }

  Widget _getStudentListView(List<Student> studentList, BuildContext context) {
    return SizedBox(
      height: defaultListHeight,
      child: ListView.builder(
          itemCount: studentList.length,
          itemBuilder: (context, index) {
            final student = studentList[index];
            return Container(
              decoration: defaultDividerDecoration,
              child: Material(
                child: InkWell(
                  mouseCursor: SystemMouseCursors.click,
                  hoverColor: Colors.white10,
                  splashColor: darkBackColor,
                  onHover: (isHover) {
                    if (isHover) {}
                  },
                  onTap: () {
                    showStudentDetail(student, context);
                  },
                  child: ListTile(
                    // horizontalTitleGap: 0.3,
                    leading: _setStudentLeading(student.photoUrl),

                    title: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            student.studentName!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          student.password == null
                              ? 'Şifre Oluşturulmamış'
                              : !_showPassword
                                  ? '******'
                                  : student.password!,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                      ],
                    ),
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
                            onPressed: () {
                              _deleteStudent(student, context);
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
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

  void showStudentDetail(Student student, BuildContext context) {
    context.router.push(AdminStudentDetailRoute(student: student));
  }

  void _deleteStudent(Student student, BuildContext context) {
    CustomDialog.showDeleteAlertDialog(
        context: context,
        message: LocaleKeys.students_studentDeleteAlert.locale([student.studentName ?? '']),
        onConfirm: () {
          context.read<ClassListCubit>().deleteStudent(student).then((value) {
            CustomDialog.showSnackBar(
              message: LocaleKeys.alerts_delete_success.locale(['Öğrenci']),
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
