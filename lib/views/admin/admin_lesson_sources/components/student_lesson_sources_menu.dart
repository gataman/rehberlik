import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/extensions.dart';
import '../../../../common/helper/excel_creator/student_trial_exam_excel_creator.dart';

import '../../../../common/constants.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../core/widgets/drop_down/drop_down_class_list.dart';
import '../../../../core/widgets/drop_down/drop_down_student_list.dart';
import '../../../../core/widgets/text/app_empty_warning_text.dart';
import '../../../../core/widgets/text/app_menu_title.dart';
import '../../../../models/student.dart';
import '../../../../models/student_with_class.dart';
import '../../admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import '../../admin_lessons/components/lesson_list_card/cubit/lesson_list_cubit.dart';
import '../../admin_students/components/student_list_card/cubit/student_list_cubit.dart';
import '../cubit/lesson_sources_cubit.dart';

// ignore: must_be_immutable
class StudentLessonSourcesMenu extends StatelessWidget {
  StudentLessonSourcesMenu({Key? key, this.selectedStudent}) : super(key: key);
  Student? selectedStudent;

  @override
  Widget build(BuildContext context) {
    if (selectedStudent != null) {
      //context.read<SubjectBloc>()
    }
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
    return BlocBuilder<LessonListCubit, LessonListState>(
      builder: (context, lessonState) {
        if (lessonState.isLoading) {
          return _lessonLoadingState();
        } else {
          if (lessonState.lessonList != null) {
            final int classIndex =
                selectedStudent != null ? _getClassIndex(classesList, state.classIndex) : state.classIndex;
            final int studentIndex =
                selectedStudent != null ? _getStudentIndex(classesList[classIndex].studentList) : state.studentIndex;

            final List<Student>? studentList = classesList[classIndex].studentList;
            final cubit = context.read<LessonSourcesCubit>();
            final Student? student = context.read<LessonSourcesCubit>().selectedStudent;
            if (studentList != null && student == null) {
              cubit.selectStudent(studentList[studentIndex], lessonState.lessonList);
            }
            return Column(
              children: [
                DropDownClassList(
                  classesList: classesList,
                  selectedIndex: classIndex,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      context.read<StudentListCubit>().selectClass(selectedIndex: classesList.indexOf(newValue));
                      context.read<LessonSourcesCubit>().selectStudent(null, null);
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
                      if (newValue != null) {
                        context.read<LessonSourcesCubit>().selectStudent(newValue, lessonState.lessonList);
                      }
                    },
                  ),
                const SizedBox(
                  height: defaultPadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        StudentTrialExamExcelCreator(context).build();
                      },
                      child: const Text('Excel Kaydet')),
                )
              ],
            );
          } else {
            return const Text('Ders listesi boş...');
          }
        }
      },
    );
  }

  int _getStudentIndex(List<Student>? studentList) {
    if (studentList != null) {
      final index = studentList.indexOf(selectedStudent!);
      if (index >= 0) {
        selectedStudent = null;
        return index;
      }
    }
    return 0;
  }

  int _getClassIndex(List<StudentWithClass> classesList, int classIndex) {
    final studentClass = classesList.findOrNull((element) => element.classes.id == selectedStudent!.classID);
    if (studentClass != null) {
      return classesList.indexOf(studentClass);
    }

    return classIndex;
  }

  Widget _lessonLoadingState() {
    return const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress());
  }
}
