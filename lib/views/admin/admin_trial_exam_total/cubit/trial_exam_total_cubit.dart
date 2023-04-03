import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../common/extensions.dart';

import '../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';
import '../../../../common/locator.dart';
import '../../../../models/trial_exam_class_result.dart';
import '../../../../models/trial_exam_student_result.dart';
import '../../../../repository/trial_exam_class_result_repository.dart';
import '../../../../repository/trial_exam_student_result_repository.dart';
import '../../admin_trial_exam_detail/helper/trial_exam_result_helper.dart';

part 'trial_exam_total_state.dart';

class TrialExamTotalCubit extends Cubit<TrialExamTotalState> {
  final _trialExamStudentResultRepository = locator<TrialExamStudentResultRepository>();
  final _helperResult = locator<TrialExamResultHelper>();
  TrialExamTotalCubit() : super(TrialExamTotalLoadingState());

  final _trialExamClassResultRepository = locator<TrialExamClassResultRepository>();

  List<TrialExamStudentResult>? trialExamStudentResultList;
  List<TrialExamClassResult>? trialExamClassResultList;
  List<TrialExamGraph> trialExamGraphList = [];
  int _classLevel = 8;

  void fetchTrialExamStudentResultList({required int classLevel}) async {
    _classLevel = classLevel;
    trialExamStudentResultList = await _trialExamStudentResultRepository.getAll(filters: {'classLevel': classLevel});

    showListState();
  }

  Future<void> fetchTrialExamClassResult({required int classLevel}) async {
    final list = await _trialExamClassResultRepository.getAll(filters: {'classLevel': classLevel});

    // listeyi grupla
    if (list != null) {
      final groupedList = list.groupBy((result) => result.className);
      List<TrialExamClassResult> classResultList = [];
      groupedList.forEach((className, resultList) {
        String classID = '';
        double turTot = 0;
        double matTot = 0;
        double fenTot = 0;
        double sosTot = 0;
        double ingTot = 0;
        double dinTot = 0;
        double topTot = 0;
        double pointTot = 0;
        int i = 0;
        for (var res in resultList) {
          turTot = turTot + res.turAvg;
          matTot = matTot + res.matAvg;
          fenTot = fenTot + res.fenAvg;
          sosTot = sosTot + res.sosAvg;
          dinTot = dinTot + res.dinAvg;
          ingTot = ingTot + res.ingAvg;
          topTot = topTot + res.totAvg;
          pointTot = pointTot + res.totPointAvg;

          i++;
        }

        double turAvg = _getNumberFormat(turTot / i);
        double matAvg = _getNumberFormat(matTot / i);
        double fenAvg = _getNumberFormat(fenTot / i);
        double ingAvg = _getNumberFormat(ingTot / i);
        double dinAvg = _getNumberFormat(dinTot / i);
        double sosAvg = _getNumberFormat(sosTot / i);
        double totAvg = _getNumberFormat(topTot / i);
        double totPointAvg = _getNumberFormat(pointTot / i);

        final TrialExamClassResult classResult = TrialExamClassResult(
          classID: classID,
          className: className,
          classLevel: classLevel,
          trialExamID: '',
          trialExamName: '',
          trialExamCode: '',
          turAvg: turAvg,
          sosAvg: sosAvg,
          dinAvg: dinAvg,
          ingAvg: ingAvg,
          matAvg: matAvg,
          fenAvg: fenAvg,
          totAvg: totAvg,
          totPointAvg: totPointAvg,
        );
        classResultList.add(classResult);
      });

      trialExamGraphList = _helperResult.getTrialExamGraphList(trialExamClassResultList: classResultList);
    }

    // Yeni liste oluştur

    // helper ile graph oluştur.
  }

  void showListState() {
    emit(TrialExamTotalLoadedState(trialExamStudentResult: trialExamStudentResultList));
  }

  void showGraphState() async {
    emit(TrialExamTotalLoadingState());
    await fetchTrialExamClassResult(classLevel: _classLevel);
    emit(TrialExamTotalGraphState(trialExamGraphList: trialExamGraphList));
  }

  double _getNumberFormat(double? net) {
    if (net != null) {
      final format = NumberFormat('#.00', 'en_US').format(net);
      return double.parse(format);
    } else {
      return 0;
    }
  }
}
