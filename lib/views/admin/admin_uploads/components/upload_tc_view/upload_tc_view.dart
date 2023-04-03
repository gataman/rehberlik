import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ga_uikit/ga_uikit.dart';
import '../../../../../common/helper/excel_creator/exam_card_generator/student_hall_list_creator.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/helper/excel_creator/exam_card_generator/exam_hall_builder.dart';
import '../../../../../common/helper/excel_creator/exam_card_generator/student_exam_card_creator.dart';
import '../../../admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'cubit/upload_tc_cubit.dart';

class UploadTcView extends StatelessWidget {
  const UploadTcView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadTcCubit(),
      child: BlocBuilder<ClassListCubit, ClassListState>(
        builder: (context, state) {
          if (state is ClassListLoadedState) {
            final allStudentList = state.allStudentList;
            if (allStudentList != null) {
              final filteredList = allStudentList.where((element) => element.classLevel == 8).toList();
              context.read<UploadTcCubit>().selectExcelFile(studentList: filteredList);
              return BlocBuilder<UploadTcCubit, UploadTcState>(
                builder: (context, state) {
                  return _content(state);
                },
              );
            }
          }

          return Container();
        },
      ),
    );
  }

  Widget _content(UploadTcState state) {
    if (state is UploadTcParsedState) {
      final list = state.parsedStudentList;
      if (list != null && list.isNotEmpty) {
        return Column(
          children: [
            const SizedBox(
              height: defaultPadding,
            ),
            GaLoadingButton(
              iconData: Icons.document_scanner_outlined,
              text: 'Sınav Giriş Belgeleri',
              loadingListener: null,
              onPressed: () async {
                StudentExamCardCreator creator = StudentExamCardCreator();
                await creator.build(list);
                /*  final ExamHallBuilder examHallBuilder = ExamHallBuilder(classesList: classesList);
                examHallBuilder.build(); */
                // StudentExamCardCreator(context).build(classesList[selectedIndex]);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            GaLoadingButton(
              iconData: Icons.document_scanner_outlined,
              text: 'Salon Öğrenci Listesi',
              loadingListener: null,
              onPressed: () async {
                StudentHallListCreator creator = StudentHallListCreator();
                await creator.build(list);
                /*  final ExamHallBuilder examHallBuilder = ExamHallBuilder(classesList: classesList);
                examHallBuilder.build(); */
                // StudentExamCardCreator(context).build(classesList[selectedIndex]);
              },
            ),
          ],
        );
      }
      return Container();
    } else if (state is UploadTcSavedState) {
      return Text('other');
    } else {
      return Text('offf');
    }
  }
}
