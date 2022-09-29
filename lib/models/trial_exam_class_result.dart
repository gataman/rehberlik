// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class TrialExamClassResult {
  String? id;
  String classID;
  String className;
  int classLevel;
  String trialExamID;
  String trialExamName;
  String trialExamCode;
  double turAvg;
  double sosAvg;
  double dinAvg;
  double ingAvg;
  double matAvg;
  double fenAvg;
  double totAvg;
  double totPointAvg;

  TrialExamClassResult({
    this.id,
    required this.classID,
    required this.className,
    required this.classLevel,
    required this.trialExamID,
    required this.trialExamName,
    required this.trialExamCode,
    required this.turAvg,
    required this.sosAvg,
    required this.dinAvg,
    required this.ingAvg,
    required this.matAvg,
    required this.fenAvg,
    required this.totAvg,
    required this.totPointAvg,
  });

  factory TrialExamClassResult.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TrialExamClassResult(
      id: snapshot.id,
      classID: data?['classID'],
      className: data?['className'],
      classLevel: data?['classLevel'],
      trialExamID: data?['trialExamID'],
      trialExamName: data?['trialExamName'],
      trialExamCode: data?['trialExamCode'],
      turAvg: data?['turAvg'],
      sosAvg: data?['sosAvg'],
      dinAvg: data?['dinAvg'],
      ingAvg: data?['ingAvg'],
      matAvg: data?['matAvg'],
      fenAvg: data?['fenAvg'],
      totAvg: data?['totAvg'],
      totPointAvg: data?['totPointAvg'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "classID": classID,
      "className": className,
      "classLevel": classLevel,
      "trialExamID": trialExamID,
      "trialExamName": trialExamName,
      "trialExamCode": trialExamCode,
      "turAvg": turAvg,
      "sosAvg": sosAvg,
      "dinAvg": dinAvg,
      "ingAvg": ingAvg,
      "matAvg": matAvg,
      "fenAvg": fenAvg,
      "totAvg": totAvg,
      "totPointAvg": totPointAvg,
    };
  }

  @override
  String toString() {
    return 'TrialExamClassResult(id: $id, classID: $classID, className: $className,classLevel:$classLevel, trialExamID: $trialExamID, trialExamName: $trialExamName, turAvg: $turAvg, sosAvg: $sosAvg, dinAvg: $dinAvg, ingAvg: $ingAvg, matAvg: $matAvg, fenAvg: $fenAvg, totAvg: $totAvg, totPointAvg: $totPointAvg)';
  }
}
