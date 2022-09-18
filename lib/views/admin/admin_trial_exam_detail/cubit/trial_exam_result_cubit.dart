import 'dart:io';

//import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/custom_result.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/common/locator.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/repository/trial_exam_result_repository.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';

import '../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';
import '../../../../models/trial_exam.dart';
import '../../../../models/trial_exam_result.dart';

part 'trial_exam_result_state.dart';

class TrialExamResultCubit extends Cubit<TrialExamResultState> {
  TrialExamResultCubit() : super(TrialExamResultListLoadingState());

  TrialExam? trialExam;
  List<TrialExamResult>? trialExamResultParsedList;
  List<TrialExamResult>? trialExamResultList;
  List<TrialExamGraph> trialExamGraphList = [];

  final List<int> wrongRowList = <int>[];
  final List<int> wrongStudentList = <int>[];

  final _trialExamResultRepository = locator<TrialExamResultRepository>();

  void fetchTrialExamResult({required TrialExam exam}) async {
    trialExam = exam;
    final list = await _trialExamResultRepository.getAll(filters: {'examID': exam.id!});
    if (list == null || list.isEmpty) {
      emit(TrialExamResultListEmptyState());
    } else {
      trialExamResultList = list;
      _setTrialExamGraphList();
      emit(TrialExamResultListLoadedState(trialExamResultList: list));
    }
  }

  Future<CustomResult> saveTrialExamResult() async {
    final customResult = CustomResult();
    if (trialExamResultParsedList != null) {
      try {
        await _trialExamResultRepository.addAll(list: trialExamResultParsedList!);
        return customResult;
      } catch (e) {
        customResult.message = 'Bir hata oluştu. Hata kodu: ${e.toString()}';
        customResult.isSuccess = false;
        return customResult;
      }
    } else {
      customResult.message = 'Öğrenci listesi boş';
      customResult.isSuccess = false;
      return customResult;
    }
  }

  void selectExcelFile({required ClassListCubit classCubit, required int classLevel}) async {
    /*
    final schoolStatsList = classCubit.schoolStatsList;
    final studentList = schoolStatsList.findOrNull((element) => element.classLevel == classLevel)?.studentList;
    if (studentList != null && studentList.isNotEmpty) {
      emit(TrialExamResultUploadingState());
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result == null) {
        emit(TrialExamResultListEmptyState());
        return;
      } else {
        if (kIsWeb) {
          //Web
          final bytes = result.files.first.bytes;
          if (bytes != null) {
            _decodeExcelFile(bytes, studentList);
          }
        } else {
          //Others
          final path = result.files.first.path;
          if (path != null) {
            var mobileBytes = await File(path).readAsBytes();
            _decodeExcelFile(mobileBytes, studentList);
          }
        }
      }
    } else {
      emit(TrialExamResultErrorState(message: 'Öğrenci listesi boş! Lütfen önce öğrenci ekleyin.'));
    }
    */
  }

  /*

  void _decodeExcelFile(Uint8List bytes, List<Student> studentList) {
    //final decoder = SpreadsheetDecoder.decodeBytes(bytes, update: false);
    debugPrint("Student List: ${studentList.length.toString()}");
    var decoder = Excel.decodeBytes(bytes);
    wrongRowList.clear();
    wrongStudentList.clear();

    int i = 1;
    List<TrialExamResult> examResultList = [];

    for (var table in decoder.tables.keys) {
      for (var row in decoder.tables[table]!.rows) {
        if (i > 2) {
          var studentNo = row[0];

          if (studentNo != null && studentNo.value is int && studentNo.value > 0) {
            final student = studentList.findOrNull((element) => element.studentNumber == studentNo.value.toString());
            if (student != null) {
              if (_checkData(row)) {
                final trialExamResult = TrialExamResult(
                  studentID: student.id!,
                  studentName: student.studentName ?? '',
                  studentNumber: student.studentNumber ?? '',
                  className: student.className ?? '',
                  examID: trialExam!.id!,
                  turDog: row[2]?.value ?? 0,
                  turYan: row[3]?.value ?? 0,
                  turNet: _getNet(row[2], row[3]),
                  sosDog: row[4]?.value ?? 0,
                  sosYan: row[5]?.value ?? 0,
                  sosNet: _getNet(row[4], row[5]),
                  dinDog: row[6]?.value ?? 0,
                  dinYan: row[7]?.value ?? 0,
                  dinNet: _getNet(row[6], row[7]),
                  ingDog: row[8]?.value ?? 0,
                  ingYan: row[9]?.value ?? 0,
                  ingNet: _getNet(row[8], row[9]),
                  matDog: row[10]?.value ?? 0,
                  matYan: row[11]?.value ?? 0,
                  matNet: _getNet(row[10], row[11]),
                  fenDog: row[12]?.value ?? 0,
                  fenYan: row[13]?.value ?? 0,
                  fenNet: _getNet(row[12], row[13]),
                );

                examResultList.add(trialExamResult);
              } else {
                wrongRowList.add(i);
              }
            } else {
              wrongStudentList.add(i);
            }
          } else {
            wrongStudentList.add(i);
          }
        }
        i++;
      }
    }

    if (examResultList.isNotEmpty) {
      trialExamResultParsedList = examResultList;
    }

    emit(TrialExamResultUploadedState(
        trialExamResultParsedList: examResultList,
        wrongRowList: wrongRowList.isNotEmpty ? wrongRowList : null,
        wrongStudentList: wrongStudentList.isNotEmpty ? wrongStudentList : null));

    //final lastList = studentList.groupBy((student) => student.className!);
    //final sortedList = SplayTreeMap<String, List<Student>>.from(lastList, (a, b) => a.compareTo(b));

    //return sortedList;
  }

  double _getNet(Data? correctRow, Data? incorrectRow) {
    if (correctRow != null && incorrectRow != null) {
      if (correctRow.value is int && incorrectRow.value is int) {
        final net = correctRow.value - (incorrectRow.value / 3);
        return net;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  bool _checkData(List<Data?> row) {
    return _checkIntData(row, 2) &&
        _checkIntData(row, 3) &&
        _checkIntData(row, 4) &&
        _checkIntData(row, 5) &&
        _checkIntData(row, 6) &&
        _checkIntData(row, 7) &&
        _checkIntData(row, 8) &&
        _checkIntData(row, 9) &&
        _checkIntData(row, 10) &&
        _checkIntData(row, 11) &&
        _checkIntData(row, 12) &&
        _checkIntData(row, 13);
  }

  bool _checkIntData(List<Data?> row, int i) => row[i] != null && row[i]!.value != null && row[i]!.value is int;
*/
  void showTrialExamStatics() {
    emit(TrialExamResultStaticsState());
  }

  void _setTrialExamGraphList() {
    if (trialExamResultList != null) {
      trialExamResultList!.sort((a, b) => a.className.compareTo(b.className));
      final groupedList = trialExamResultList!.groupBy((trialExamResult) => trialExamResult.className);

      final turGraph = TrialExamGraph(graphLabelName: 'Türkçe', lessonType: LessonType.twenty);
      final matGraph = TrialExamGraph(graphLabelName: 'Matematik', lessonType: LessonType.twenty);
      final fenGraph = TrialExamGraph(graphLabelName: 'Fen Bilimleri', lessonType: LessonType.twenty);
      final sosGraph = TrialExamGraph(graphLabelName: 'Sosyal Bilgiler', lessonType: LessonType.ten);
      final ingGraph = TrialExamGraph(graphLabelName: 'İngilizce', lessonType: LessonType.ten);
      final dinGraph = TrialExamGraph(graphLabelName: 'Din Kültürü', lessonType: LessonType.ten);

      groupedList.forEach((className, list) {
        double turTotalNet = 0;
        double matTotalNet = 0;
        double fenTotalNet = 0;
        double sosTotalNet = 0;
        double ingTotalNet = 0;
        double dinTotalNet = 0;
        var i = 0;

        for (var trialExamResult in list) {
          turTotalNet = turTotalNet + trialExamResult.turNet!;
          matTotalNet = matTotalNet + trialExamResult.matNet!;
          fenTotalNet = fenTotalNet + trialExamResult.fenNet!;
          sosTotalNet = sosTotalNet + trialExamResult.sosNet!;
          ingTotalNet = ingTotalNet + trialExamResult.ingNet!;
          dinTotalNet = dinTotalNet + trialExamResult.dinNet!;
          i++;
        }
        var turAvg = double.parse((turTotalNet / i).toStringAsFixed(2));
        var matAvg = double.parse((matTotalNet / i).toStringAsFixed(2));
        var fenAvg = double.parse((fenTotalNet / i).toStringAsFixed(2));
        var sosAvg = double.parse((sosTotalNet / i).toStringAsFixed(2));
        var dinAvg = double.parse((dinTotalNet / i).toStringAsFixed(2));
        var ingAvg = double.parse((ingTotalNet / i).toStringAsFixed(2));

        turGraph.itemList.add(TrialExamGraphItem(itemName: className, value: turAvg));
        matGraph.itemList.add(TrialExamGraphItem(itemName: className, value: matAvg));
        fenGraph.itemList.add(TrialExamGraphItem(itemName: className, value: fenAvg));
        sosGraph.itemList.add(TrialExamGraphItem(itemName: className, value: sosAvg));
        ingGraph.itemList.add(TrialExamGraphItem(itemName: className, value: ingAvg));
        dinGraph.itemList.add(TrialExamGraphItem(itemName: className, value: dinAvg));
      });

      trialExamGraphList.add(turGraph);
      trialExamGraphList.add(matGraph);
      trialExamGraphList.add(fenGraph);
      trialExamGraphList.add(sosGraph);
      trialExamGraphList.add(ingGraph);
      trialExamGraphList.add(dinGraph);
    }
  }
}
