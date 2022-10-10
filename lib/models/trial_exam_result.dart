import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehberlik/models/trial_exam.dart';

class TrialExamResult {
  String? id;
  String studentID;
  String studentName;
  String studentNumber;
  String className;
  String classID;
  String? examID;
  int? turDog;
  int? turYan;
  double? turNet;
  int? matDog;
  int? matYan;
  double? matNet;
  int? fenDog;
  int? fenYan;
  double? fenNet;
  int? sosDog;
  int? sosYan;
  double? sosNet;
  int? ingDog;
  int? ingYan;
  double? ingNet;
  int? dinDog;
  int? dinYan;
  double? dinNet;
  double? totalPoint;
  int schoolRank;
  int classRank;
  TrialExam? trialExam;

  TrialExamResult(
      {this.id,
      required this.studentID,
      required this.studentName,
      required this.studentNumber,
      required this.className,
      required this.classID,
      required this.examID,
      this.turDog,
      this.turYan,
      this.turNet,
      this.matDog,
      this.matYan,
      this.matNet,
      this.fenDog,
      this.fenYan,
      this.fenNet,
      this.sosDog,
      this.sosYan,
      this.sosNet,
      this.ingDog,
      this.ingYan,
      this.ingNet,
      this.dinDog,
      this.dinYan,
      this.dinNet,
      required this.totalPoint,
      this.schoolRank = 0,
      this.classRank = 0,
      this.trialExam});

  factory TrialExamResult.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TrialExamResult(
      id: snapshot.id,
      studentID: data?['studentID'],
      studentName: data?['studentName'],
      studentNumber: data?['studentNumber'],
      className: data?['className'],
      classID: data?['classID'],
      examID: data?['examID'],
      turDog: data?['turDog'],
      turYan: data?['turYan'],
      turNet: data?['turNet'],
      matDog: data?['matDog'],
      matYan: data?['matYan'],
      matNet: data?['matNet'],
      fenDog: data?['fenDog'],
      fenYan: data?['fenYan'],
      fenNet: data?['fenNet'],
      sosDog: data?['sosDog'],
      sosYan: data?['sosYan'],
      sosNet: data?['sosNet'],
      ingDog: data?['ingDog'],
      ingYan: data?['ingYan'],
      ingNet: data?['ingNet'],
      dinDog: data?['dinDog'],
      dinYan: data?['dinYan'],
      dinNet: data?['dinNet'],
      totalPoint: data?['totalPoint'],
      schoolRank: data?['schoolRank'],
      classRank: data?['classRank'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "studentID": studentID,
      "studentName": studentName,
      "studentNumber": studentNumber,
      "className": className,
      "classID": classID,
      "examID": examID,
      "turDog": turDog,
      "turYan": turYan,
      "turNet": turNet,
      "matDog": matDog,
      "matYan": matYan,
      "matNet": matNet,
      "fenDog": fenDog,
      "fenYan": fenYan,
      "fenNet": fenNet,
      "sosDog": sosDog,
      "sosYan": sosYan,
      "sosNet": sosNet,
      "ingDog": ingDog,
      "ingYan": ingYan,
      "ingNet": ingNet,
      "dinDog": dinDog,
      "dinYan": dinYan,
      "dinNet": dinNet,
      "totalPoint": totalPoint,
      "schoolRank": schoolRank,
      "classRank": classRank,
    };
  }

  @override
  String toString() {
    return 'TrialExamResult{id: $id, studentID: $studentID, studentName: $studentName, studentNumber: $studentNumber, className: $className, classID: $classID, examID: $examID, turDog: $turDog, turYan: $turYan, turNet: $turNet, matDog: $matDog, matYan: $matYan, matNet: $matNet, fenDog: $fenDog, fenYan: $fenYan, fenNet: $fenNet, sosDog: $sosDog, sosYan: $sosYan, sosNet: $sosNet, ingDog: $ingDog, ingYan: $ingYan, ingNet: $ingNet, dinDog: $dinDog, dinYan: $dinYan, dinNet: $dinNet, totalPoint: $totalPoint, schoolRank: $schoolRank, classRank : $classRank, trialExam : $trialExam}';
  }
}
