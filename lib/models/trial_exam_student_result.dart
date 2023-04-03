// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehberlik/common/extensions.dart';

class TrialExamStudentResult {
  String studentID;
  String? studentName;
  String? studentNumber;
  String? classID;
  String? className;
  int? classLevel;
  double turDogAvg;
  double turYanAvg;
  double turNetAvg;
  double sosDogAvg;
  double sosYanAvg;
  double sosNetAvg;
  double dinDogAvg;
  double dinYanAvg;
  double dinNetAvg;
  double ingDogAvg;
  double ingYanAvg;
  double ingNetAvg;
  double matDogAvg;
  double matYanAvg;
  double matNetAvg;
  double fenDogAvg;
  double fenYanAvg;
  double fenNetAvg;
  double totDogAvg;
  double totYanAvg;
  double totNetAvg;
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
    this.turDogAvg = 0,
    this.turYanAvg = 0,
    this.turNetAvg = 0,
    this.sosDogAvg = 0,
    this.sosYanAvg = 0,
    this.sosNetAvg = 0,
    this.dinDogAvg = 0,
    this.dinYanAvg = 0,
    this.dinNetAvg = 0,
    this.ingDogAvg = 0,
    this.ingYanAvg = 0,
    this.ingNetAvg = 0,
    this.matDogAvg = 0,
    this.matYanAvg = 0,
    this.matNetAvg = 0,
    this.fenDogAvg = 0,
    this.fenYanAvg = 0,
    this.fenNetAvg = 0,
    this.totDogAvg = 0,
    this.totYanAvg = 0,
    this.totNetAvg = 0,
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
      turDogAvg: data.parseDouble('turDogAvg'),
      turYanAvg: data.parseDouble('turYanAvg'),
      turNetAvg: data.parseDouble('turNetAvg'),
      sosDogAvg: data.parseDouble('sosDogAvg'),
      sosYanAvg: data.parseDouble('sosYanAvg'),
      sosNetAvg: data.parseDouble('sosNetAvg'),
      dinDogAvg: data.parseDouble('dinDogAvg'),
      dinYanAvg: data.parseDouble('dinYanAvg'),
      dinNetAvg: data.parseDouble('dinNetAvg'),
      ingDogAvg: data.parseDouble('ingDogAvg'),
      ingYanAvg: data.parseDouble('ingYanAvg'),
      ingNetAvg: data.parseDouble('ingNetAvg'),
      matDogAvg: data.parseDouble('matDogAvg'),
      matYanAvg: data.parseDouble('matYanAvg'),
      matNetAvg: data.parseDouble('matNetAvg'),
      fenDogAvg: data.parseDouble('fenDogAvg'),
      fenYanAvg: data.parseDouble('fenYanAvg'),
      fenNetAvg: data.parseDouble('fenNetAvg'),
      totDogAvg: data.parseDouble('totDogAvg'),
      totYanAvg: data.parseDouble('totYanAvg'),
      totNetAvg: data.parseDouble('totNetAvg'),
      totalPointAvg: data.parseDouble('totPointAvg'),
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
      "turDogAvg": turDogAvg,
      "turYanAvg": turYanAvg,
      "turNetAvg": turNetAvg,
      "sosDogAvg": sosDogAvg,
      "sosYanAvg": sosYanAvg,
      "sosNetAvg": sosNetAvg,
      "dinDogAvg": dinDogAvg,
      "dinYanAvg": dinYanAvg,
      "dinNetAvg": dinNetAvg,
      "ingDogAvg": ingDogAvg,
      "ingYanAvg": ingYanAvg,
      "ingNetAvg": ingNetAvg,
      "matDogAvg": matDogAvg,
      "matYanAvg": matYanAvg,
      "matNetAvg": matNetAvg,
      "fenDogAvg": fenDogAvg,
      "fenYanAvg": fenYanAvg,
      "fenNetAvg": fenNetAvg,
      "totDogAvg": totDogAvg,
      "totYanAvg": totYanAvg,
      "totNetAvg": totNetAvg,
      "totPointAvg": totalPointAvg,
      "classRank": classRank,
      'schoolRank': schoolRank
    };
  }

  @override
  String toString() {
    return 'TrialExamStudentResult(studentID: $studentID, studentName: $studentName, studentNumber: $studentNumber, classID: $classID, className: $className, classLevel: $classLevel, turDogAvg: $turDogAvg, turYanAvg: $turYanAvg, turNetAvg: $turNetAvg, sosDogAvg: $sosDogAvg, sosYanAvg: $sosYanAvg, sosNetAvg: $sosNetAvg, dinDogAvg: $dinDogAvg, dinYanAvg: $dinYanAvg, dinNetAvg: $dinNetAvg, ingDogAvg: $ingDogAvg, ingYanAvg: $ingYanAvg, ingNetAvg: $ingNetAvg, matDogAvg: $matDogAvg, matYanAvg: $matYanAvg, matNetAvg: $matNetAvg, fenDogAvg: $fenDogAvg, fenYanAvg: $fenYanAvg, fenNetAvg: $fenNetAvg, totDogAvg: $totDogAvg, totYanAvg: $totYanAvg, totNetAvg: $totNetAvg, totalPointAvg: $totalPointAvg, classRank: $classRank, schoolRank: $schoolRank)';
  }
}
