import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_excel/excel.dart';
import '../../../../common/extensions.dart';
import '../../../../common/custom_result.dart';
import '../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';
import '../../../../common/locator.dart';
import '../../../../models/student.dart';
import '../../../../models/trial_exam.dart';
import '../../../../models/trial_exam_class_result.dart';
import '../../../../models/trial_exam_result.dart';
import '../../../../repository/trial_exam_class_result_repository.dart';
import '../../../../repository/trial_exam_repository.dart';
import '../../../../repository/trial_exam_result_repository.dart';
import '../../../../repository/trial_exam_student_result_repository.dart';
import '../../admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import '../helper/trial_exam_result_helper.dart';
import '../helper/trial_exam_student_result_helper.dart';

part 'trial_exam_result_state.dart';

class TrialExamResultCubit extends Cubit<TrialExamResultState> {
  TrialExamResultCubit() : super(TrialExamResultListLoadingState());

  TrialExam? trialExam;
  List<TrialExamResult>? trialExamResultParsedList;
  List<TrialExamResult>? trialExamResultList;
  List<TrialExamClassResult> trialExamClassResultList = [];
  List<TrialExamGraph> trialExamGraphList = [];

  final List<int> wrongRowList = <int>[];
  final List<int> wrongStudentList = <int>[];
  final List<int> duplicateNumberList = <int>[];

  final _trialExamRepository = locator<TrialExamRepository>();
  final _trialExamResultRepository = locator<TrialExamResultRepository>();
  final _trialExamClassResultRepository = locator<TrialExamClassResultRepository>();
  final _trialExamStudentResultRepository = locator<TrialExamStudentResultRepository>();
  final _helperStudentResult = locator<TrialExamStudentResultHelper>();
  final _helperResult = locator<TrialExamResultHelper>();

  void fetchTrialExamResult({required TrialExam exam}) async {
    trialExam = exam;
    final list = await _trialExamResultRepository.getAll(filters: {'examID': exam.id!});
    if (list == null || list.isEmpty) {
      emit(TrialExamResultListEmptyState());
    } else {
      trialExamResultList = list;
      trialExamResultList?.sort(
        (a, b) => a.totalPoint!.compareTo(b.totalPoint!),
      );

      _setTrialExamGraphList();
      emit(TrialExamResultListLoadedState(trialExamResultList: trialExamResultList!));
    }
  }

  Future<CustomResult> saveTrialExamResult() async {
    final customResult = CustomResult();
    if (trialExamResultParsedList != null) {
      try {
        await _trialExamResultRepository.addAll(list: trialExamResultParsedList!);
        _saveAllClassResult();

        if (trialExam?.classLevel != null) {
          calculateAllStudentRanks(trialExam!.classLevel!);
        }

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

  void showTrialExamStatics() {
    emit(TrialExamResultStaticsState(trialExamGraphList: trialExamGraphList));
  }

  void _setTrialExamGraphList() async {
    final list = await _trialExamClassResultRepository.getAll(filters: {'trialExamID': trialExam!.id!});

    if (list != null) {
      trialExamClassResultList = list;
      trialExamGraphList = _helperResult.getTrialExamGraphList(trialExamClassResultList: list);
    }
  }

  void selectExcelFile({required ClassListCubit classCubit, required int classLevel}) async {
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
            _decodeExcelFile(bytes, studentList, classLevel);
          }
        } else {
          //Others
          final path = result.files.first.path;
          if (path != null) {
            var mobileBytes = await File(path).readAsBytes();
            _decodeExcelFile(mobileBytes, studentList, classLevel);
          }
        }
      }
    } else {
      emit(TrialExamResultErrorState(message: 'Öğrenci listesi boş! Lütfen önce öğrenci ekleyin.'));
    }
  }

  void _decodeExcelFile(Uint8List bytes, List<Student> studentList, int classLevel) {
    //final decoder = SpreadsheetDecoder.decodeBytes(bytes, update: false);
    var decoder = Excel.decodeBytes(bytes);
    wrongRowList.clear();
    wrongStudentList.clear();
    duplicateNumberList.clear();
    List<int> studentNumberList = <int>[];

    int i = 1;
    List<TrialExamResult> examResultList = [];

    for (var table in decoder.tables.keys) {
      for (var row in decoder.tables[table]!.rows) {
        if (i > 2) {
          var studentNo = row[0];

          if (studentNo != null && studentNo.value is int && studentNo.value > 0) {
            final student = studentList.findOrNull((element) => element.studentNumber == studentNo.value.toString());
            if (student != null) {
              var number = int.tryParse(studentNo.value.toString());
              if (number != null) {
                final findingNumber = studentNumberList.findOrNull((element) => element == number);
                if (findingNumber != null) {
                  debugPrint('Çiftleyen numara : $number');
                  duplicateNumberList.add(number);
                } else {
                  debugPrint('---------------------');
                  debugPrint('numara : $number');
                  studentNumberList.add(number);
                }
              }
              if (_checkData(row)) {
                TrialExamResult trialExamResult = _helperResult.buildTrialExamResult(row, student, trialExam!);
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
      _createStudentRanks(examResultList);

      trialExamResultParsedList = examResultList;
    }

    emit(TrialExamResultUploadedState(
        trialExamResultParsedList: examResultList,
        wrongRowList: wrongRowList.isNotEmpty ? wrongRowList : null,
        wrongStudentList: wrongStudentList.isNotEmpty ? wrongStudentList : null,
        duplicateNumberList: duplicateNumberList.isNotEmpty ? duplicateNumberList : null));
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

  void _saveAllClassResult() {
    if (trialExamResultParsedList != null) {
      final list = _helperResult.getTrialExamClassResultList(
        trialExamResultList: trialExamResultParsedList,
        trialExam: trialExam!,
      );
      _trialExamClassResultRepository.addAll(list: list);
    }
  }

  void _createStudentRanks(List<TrialExamResult> examResultList) {
    examResultList.sort((a, b) => b.totalPoint!.compareTo(a.totalPoint!));
    int schoolRank = 1;
    for (var element in examResultList) {
      element.schoolRank = schoolRank;
      schoolRank++;
    }

    final groupedList = examResultList.groupBy((trialExamResult) => trialExamResult.className);

    groupedList.forEach((className, list) {
      int classRank = 1;
      for (var element in list) {
        element.classRank = classRank;
        classRank++;
      }
    });
  }

  void calculateAllStudentRanks(int classLevel) async {
    final List<TrialExamResult> trialExamAllResultList = [];

    // Sınıf seviyesine göre bütün sınavlar çekildi:
    final trialExamList = await _trialExamRepository.getAll(filters: {'classLevel': classLevel});

    if (trialExamList != null && trialExamList.isNotEmpty) {
      for (var exam in trialExamList) {
        final examResultList = await _trialExamResultRepository.getAll(filters: {'examID': exam.id!});
        if (examResultList != null && examResultList.isNotEmpty) {
          // Bütün listeler dolduruldu.
          trialExamAllResultList.addAll(examResultList);
        }
      }
    }

    if (trialExamAllResultList.isNotEmpty) {
      final trialExamStudentResultList = _helperStudentResult.createTrialExamStudentResultList(
          trialExamAllResultList: trialExamAllResultList, classLevel: classLevel);
      _trialExamStudentResultRepository.addAll(list: trialExamStudentResultList);
    }
  }
}
