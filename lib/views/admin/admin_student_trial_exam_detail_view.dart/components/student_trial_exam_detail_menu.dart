import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/views/admin/admin_student_trial_exam_detail_view.dart/cubit/student_trial_exam_detail_cubit.dart';

import '../../../../common/constants.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../core/widgets/drop_down/drop_down_class_list.dart';
import '../../../../core/widgets/drop_down/drop_down_student_list.dart';
import '../../../../core/widgets/text/app_empty_warning_text.dart';
import '../../../../core/widgets/text/app_menu_title.dart';
import '../../../../models/student.dart';
import '../../../../models/student_with_class.dart';
import '../../admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import '../../admin_students/components/student_list_card/cubit/student_list_cubit.dart';

class StudentTrialExamDetailMenu extends StatelessWidget {
  const StudentTrialExamDetailMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: defaultPadding),
          child: BlocBuilder<ClassListCubit, ClassListState>(builder: (context, classState) {
            if (classState is ClassListLoadedState) {
              final List<StudentWithClass>? classesList = classState.studentWithClassList;
              return Column(
                children: [
                  _title(),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  _getDropDownMenu(classesList),
                ],
              );
            } else {
              return const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress());
            }
          })),
    );
  }

  Widget _title() {
    return const AppMenuTitle(
      title: 'Sınıf ve Öğrenci Seç',
    );
  }

  Widget _getDropDownMenu(List<StudentWithClass>? classesList) {
    if (classesList != null && classesList.isNotEmpty) {
      return BlocBuilder<StudentListCubit, StudentListState>(builder: (context, state) {
        if (state is SelectedIndexState) {
          return _buildDropdownButtonColumns(state: state, context: context, classesList: classesList);
        } else {
          return const AppEmptyWarningText(text: "Sınıf listesi yüklenemedi!");
        }
      });
    } else {
      return const AppEmptyWarningText(text: "Sınıf listesi yüklenemedi!");
    }
  }

  Widget _buildDropdownButtonColumns(
      {required List<StudentWithClass> classesList, required SelectedIndexState state, required BuildContext context}) {
    final int classIndex = state.classIndex;
    final int studentIndex = state.studentIndex;
    final List<Student>? studentList = classesList[classIndex].studentList;
    final cubit = context.read<StudentTrialExamDetailCubit>();
    final Student? student = context.read<StudentTrialExamDetailCubit>().selectedStudent;
    if (studentList != null && student == null) {
      cubit.selectStudent(studentList[studentIndex]);
    }
    return Column(
      children: [
        DropDownClassList(
          classesList: classesList,
          selectedIndex: classIndex,
          onChanged: (newValue) {
            if (newValue != null) {
              context.read<StudentListCubit>().selectClass(selectedIndex: classesList.indexOf(newValue));
            }
          },
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        if (studentList != null && studentList.isNotEmpty)
          DropDownStudentList(
            studentList: studentList,
            selectedStudentIndex: studentIndex,
            onChanged: (newValue) {
              debugPrint('Öğrenci seçildi');
              if (newValue != null) {
                context.read<StudentTrialExamDetailCubit>().selectStudent(newValue);
              }
            },
          ),
      ],
    );
  }
}
