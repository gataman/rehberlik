import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/helper/excel_creator/student_password_excel_creator.dart';
import '../../../../../common/constants.dart';
import '../../../../../common/widgets/default_circular_progress.dart';
import '../../../../../common/widgets/loading_button.dart';
import '../../../../../core/init/extentions.dart';
import '../../../../../core/init/locale_keys.g.dart';
import '../../../../../core/widgets/drop_down/drop_down_class_list.dart';
import '../../../../../core/widgets/text/app_empty_warning_text.dart';
import '../../../../../core/widgets/text/app_menu_title.dart';
import '../../../../../models/student_with_class.dart';
import '../../../admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import '../student_list_card/cubit/student_list_cubit.dart';

class StudentFormBox extends StatelessWidget {
  final bool hasPasswordMenu;

  StudentFormBox({Key? key, required this.hasPasswordMenu}) : super(key: key);
  final ValueNotifier<bool> buttonListener = ValueNotifier(false);
  late final StudentPasswordExcelCrator _excelCrator;

  @override
  Widget build(BuildContext context) {
    _excelCrator = StudentPasswordExcelCrator(context);
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
                  // if (hasPasswordMenu)
                  //   const SizedBox(
                  //     height: defaultPadding,
                  //   ),
                  // if (hasPasswordMenu)
                  //   LoadingButton(
                  //     text: 'Tüm Sınıflara Şifre Oluştur',
                  //     loadingListener: buttonListener,
                  //     onPressed: () {
                  //       _generateAllStudentPassword(context);
                  //     },
                  //   ),
                  if (hasPasswordMenu)
                    const SizedBox(
                      height: defaultPadding,
                    ),
                  if (hasPasswordMenu)
                    LoadingButton(
                      text: 'Şifreleri İndir',
                      loadingListener: _excelCrator.notifier,
                      onPressed: () {
                        _excelCrator.build(classesList!);
                      },
                    ),
                ],
              );
            } else {
              return const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress());
            }
          })),
    );
  }

  Widget _title() {
    return AppMenuTitle(
      title: LocaleKeys.students_classSelectTitle.locale(),
    );
  }

  Widget _getDropDownMenu(List<StudentWithClass>? classesList) {
    if (classesList != null && classesList.isNotEmpty) {
      return BlocBuilder<StudentListCubit, StudentListState>(builder: (context, state) {
        final selectedIndex = state is SelectedIndexState ? state.classIndex : 0;
        return _buildDropdownButtonFormField(classesList, selectedIndex, context);
      });
    } else {
      return const AppEmptyWarningText(text: "Sınıf listesi yüklenemedi!");
    }
  }

  Widget _buildDropdownButtonFormField(List<StudentWithClass> classesList, int selectedIndex, BuildContext context) {
    return DropDownClassList(
      classesList: classesList,
      selectedIndex: selectedIndex,
      onChanged: (newValue) {
        if (newValue != null) {
          context.read<StudentListCubit>().selectClass(selectedIndex: classesList.indexOf(newValue));
        }
      },
    );
  }

  void _generateAllStudentPassword(BuildContext context) {
    context.read<ClassListCubit>().updateAllStudentPassword();
  }
}
