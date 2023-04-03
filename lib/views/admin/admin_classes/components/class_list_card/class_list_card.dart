import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/init/extensions.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/custom_dialog.dart';
import '../../../../../common/navigaton/app_router/app_routes.dart';
import '../../../../../common/widgets/default_circular_progress.dart';
import '../../../../../core/init/locale_keys.g.dart';
import '../../../../../core/widgets/containers/app_list_box_container.dart';
import '../../../../../core/widgets/list_tiles/app_liste_tile.dart';
import '../../../../../core/widgets/text/app_box_title.dart';
import '../../../../../core/widgets/text/app_empty_warning_text.dart';
import '../../../../../models/classes.dart';
import '../../../admin_students/components/student_list_card/cubit/student_list_cubit.dart';
import '../class_form_box/cubit/class_form_box_cubit.dart';
import 'cubit/class_list_cubit.dart';

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
          if (state is ClassListLoadedState) _getClassesListView(state, context),
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

  Widget _getClassesListView(ClassListLoadedState state, BuildContext context) {
    if (state.studentWithClassList != null && state.studentWithClassList!.isNotEmpty) {
      final classesList = state.studentWithClassList!;
      final height = MediaQuery.of(context).size.height;
      return SizedBox(
        height: height * .8,
        child: ListView.separated(
            itemCount: classesList.length,
            separatorBuilder: (context, index) => defaultDivider,
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
