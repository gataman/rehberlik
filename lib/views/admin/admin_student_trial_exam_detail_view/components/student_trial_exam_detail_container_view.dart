import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'package:rehberlik/views/admin/admin_dashboard/admin_dashboard_imports.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../common/constants.dart';
import '../../../../common/widgets/default_circular_progress.dart';
import '../../../../core/widgets/containers/app_list_box_container.dart';
import '../../../../core/widgets/text/app_box_title.dart';
import '../cubit/student_trial_exam_detail_cubit.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'student_trial_exam_detail_card/student_trial_exam_detail_card.dart';

class StudentTrialExamDetailContainerView extends StatelessWidget {
  StudentTrialExamDetailContainerView({Key? key}) : super(key: key);
  final ScreenshotController screenshotController = ScreenshotController();
  final WebImageDownloader _webImageDownloader = WebImageDownloader();

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(
      child: Column(
        children: [
          const AppBoxTitle(isBack: false, title: 'Deneme Sınavları Öğrenci Sonuç Karnesi'),
          BlocBuilder<StudentTrialExamDetailCubit, StudentTrialExamDetailState>(
            builder: (context, state) {
              if (state is StudentTrialExamStudentSelectedStade) {
                final studentTrialExamResultList = state.studentTrialExamResultList;
                final student = state.student;
                final trialExamStudentResult = state.trialExamStudentResult;
                final studentTrialExamGraphList = state.studentTrialExamGraphList;
                final totalNetGraph = state.totalNetGraph;
                final classAverages = state.classAverages;
                final schoolAverages = state.schoolAverages;

                if (studentTrialExamResultList != null &&
                    studentTrialExamResultList.isNotEmpty &&
                    trialExamStudentResult != null &&
                    studentTrialExamGraphList != null &&
                    schoolAverages != null &&
                    classAverages != null &&
                    totalNetGraph != null) {
                  return Column(
                    children: [
                      StudentTrialExamDetailCard(
                        student: student,
                        studentTrialExamResultList: studentTrialExamResultList,
                        trialExamStudentResult: trialExamStudentResult,
                        studentTrialExamGraphList: studentTrialExamGraphList,
                        totalNetGraph: totalNetGraph,
                        classAverages: classAverages,
                        schoolAverages: schoolAverages,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _createPdf(context);
                          },
                          child: const Text('PdfOluştur'))
                    ],
                  );

                  //return MyPieChart();
                } else {
                  return SizedBox(
                      height: minimumBoxHeight,
                      child: Center(
                          child: Text(
                        'Öğrencinin deneme sınavı sonucu bulunamadı!',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )));
                }
              } else {
                return const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress());
              }
            },
          )
        ],
      ),
    );
  }

  Future<void> _createPdf(BuildContext context) async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(child: pw.Text('Deneme'));
          }),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
  }

  void _captureImage(Widget studentTrialExamDetailCard) {
    screenshotController.captureFromWidget(studentTrialExamDetailCard).then((image) {
      debugPrint('image: ${image.toString()}');
      _webImageDownloader.downloadImageFromUInt8List(uInt8List: image);
    });
  }
}

class MyPieChart extends StatelessWidget {
  const MyPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentClassList = context.read<ClassListCubit>().studentWithClassList;
    final studenList = studentClassList![14].studentList!;

    final katsayi = 0.00979;

    return SizedBox(
      height: 500,
      child: PieChart(
        PieChartData(
          sectionsSpace: 1,
          centerSpaceRadius: 0,
          sections: [
            for (int i = 0; i < studenList.length; i++)
              PieChartSectionData(
                value: 1,
                radius: 250,
                showTitle: false,
                badgePositionPercentageOffset: .7,
                badgeWidget: Transform.rotate(
                  angle: ((i + 1) * (studenList.length * katsayi)),
                  child: Text(studenList[i].studentName!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
