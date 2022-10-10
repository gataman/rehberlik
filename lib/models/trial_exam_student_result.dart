// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class TrialExamStudentResult {
  String studentID;
  String? studentName;
  String? studentNumber;
  String? classID;
  String? className;
  int? classLevel;
  double turAvg;
  double sosAvg;
  double dinAvg;
  double ingAvg;
  double matAvg;
  double fenAvg;
  double totAvg;
  double totalPointAvg;
  int classRank;
  int schoolRank;

  TrialExamStudentResult({
    required this.studentID,
    this.studentName,
    this.studentNumber,
    this.classID,
    this.className,
    this.classLevel,
    this.turAvg = 0,
    this.sosAvg = 0,
    this.dinAvg = 0,
    this.ingAvg = 0,
    this.matAvg = 0,
    this.fenAvg = 0,
    this.totAvg = 0,
    this.totalPointAvg = 0,
    this.classRank = 0,
    this.schoolRank = 0,
  });

  factory TrialExamStudentResult.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TrialExamStudentResult(
      studentID: data?['studentID'],
      studentName: data?['studentName'],
      studentNumber: data?['studentNumber'],
      classID: data?['classID'],
      className: data?['className'],
      classLevel: data?['classLevel'],
      turAvg: data?['turAvg'],
      sosAvg: data?['sosAvg'],
      dinAvg: data?['dinAvg'],
      ingAvg: data?['ingAvg'],
      matAvg: data?['matAvg'],
      fenAvg: data?['fenAvg'],
      totAvg: data?['totAvg'],
      totalPointAvg: data?['totPointAvg'],
      classRank: data?['classRank'],
      schoolRank: data?['schoolRank'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "studentID": studentID,
      "classID": classID,
      "className": className,
      "classLevel": classLevel,
      "studentName": studentName,
      "studentNumber": studentNumber,
      "turAvg": turAvg,
      "sosAvg": sosAvg,
      "dinAvg": dinAvg,
      "ingAvg": ingAvg,
      "matAvg": matAvg,
      "fenAvg": fenAvg,
      "totAvg": totAvg,
      "totPointAvg": totalPointAvg,
      "classRank": classRank,
      'schoolRank': schoolRank
    };
  }

  @override
  String toString() {
    return 'TrialExamStudentResult(studentID: $studentID, studentName: $studentName, studentNumber: $studentNumber, classID: $classID, className: $className, classLevel: $classLevel, turAvg: $turAvg, sosAvg: $sosAvg, dinAvg: $dinAvg, ingAvg: $ingAvg, matAvg: $matAvg, fenAvg: $fenAvg, totAvg: $totAvg, totPointAvg: $totalPointAvg, classRank: $classRank, schoolRank: $schoolRank)';
  }
}
