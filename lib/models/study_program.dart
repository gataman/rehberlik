import 'package:cloud_firestore/cloud_firestore.dart';

class StudyProgram {
  String? id;
  String? studentID;
  DateTime? date;
  int? turTarget;
  int? turSolved;
  int? turCorrect;
  int? turIncorrect;
  int? matTarget;
  int? matSolved;
  int? matCorrect;
  int? matIncorrect;
  int? fenTarget;
  int? fenSolved;
  int? fenCorrect;
  int? fenIncorrect;
  int? inkTarget;
  int? inkSolved;
  int? inkCorrect;
  int? inkIncorrect;
  int? ingTarget;
  int? ingSolved;
  int? ingCorrect;
  int? ingIncorrect;
  int? dinTarget;
  int? dinSolved;
  int? dinCorrect;
  int? dinIncorrect;

  StudyProgram({
    this.id,
    required this.studentID,
    required this.date,
    this.turTarget,
    this.turSolved,
    this.turCorrect,
    this.turIncorrect,
    this.matTarget,
    this.matSolved,
    this.matCorrect,
    this.matIncorrect,
    this.fenTarget,
    this.fenSolved,
    this.fenCorrect,
    this.fenIncorrect,
    this.inkTarget,
    this.inkSolved,
    this.inkCorrect,
    this.inkIncorrect,
    this.ingTarget,
    this.ingSolved,
    this.ingCorrect,
    this.ingIncorrect,
    this.dinTarget,
    this.dinSolved,
    this.dinCorrect,
    this.dinIncorrect,
  });

  factory StudyProgram.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return StudyProgram(
      id: snapshot.id,
      studentID: data?['studentID'],
      date: (data?['date'] as Timestamp).toDate(),
      turTarget: data?['turTarget'],
      turSolved: data?['turSolved'],
      turCorrect: data?['turCorrect'],
      turIncorrect: data?['turIncorrect'],
      matTarget: data?['matTarget'],
      matSolved: data?['matSolved'],
      matCorrect: data?['matCorrect'],
      matIncorrect: data?['matIncorrect'],
      fenTarget: data?['fenTarget'],
      fenSolved: data?['fenSolved'],
      fenCorrect: data?['fenCorrect'],
      fenIncorrect: data?['fenIncorrect'],
      inkTarget: data?['inkTarget'],
      inkSolved: data?['inkSolved'],
      inkCorrect: data?['inkCorrect'],
      inkIncorrect: data?['inkIncorrect'],
      ingTarget: data?['ingTarget'],
      ingSolved: data?['ingSolved'],
      ingCorrect: data?['ingCorrect'],
      ingIncorrect: data?['ingIncorrect'],
      dinTarget: data?['dinTarget'],
      dinSolved: data?['dinSolved'],
      dinCorrect: data?['dinCorrect'],
      dinIncorrect: data?['dinIncorrect'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (studentID != null) "studentID": studentID,
      if (date != null) "date": date,
      "turTarget": turTarget,
      "turSolved": turSolved,
      "turCorrect": turCorrect,
      "turIncorrect": turIncorrect,
      "matTarget": matTarget,
      "matSolved": matSolved,
      "matCorrect": matCorrect,
      "matIncorrect": matIncorrect,
      "fenTarget": fenTarget,
      "fenSolved": fenSolved,
      "fenCorrect": fenCorrect,
      "fenIncorrect": fenIncorrect,
      "inkTarget": inkTarget,
      "inkSolved": inkSolved,
      "inkCorrect": inkCorrect,
      "inkIncorrect": inkIncorrect,
      "ingTarget": ingTarget,
      "ingSolved": ingSolved,
      "ingCorrect": ingCorrect,
      "ingIncorrect": ingIncorrect,
      "dinTarget": dinTarget,
      "dinSolved": dinSolved,
      "dinCorrect": dinCorrect,
      "dinIncorrect": dinIncorrect,
    };
  }

  @override
  String toString() {
    return 'StudyProgram{id: $id, studentID: $studentID, date: $date, turTarget: $turTarget, turSolved: $turSolved, turCorrect: $turCorrect, turIncorrect: $turIncorrect, matTarget: $matTarget, matSolved: $matSolved, matCorrect: $matCorrect, matIncorrect: $matIncorrect, fenTarget: $fenTarget, fenSolved: $fenSolved, fenCorrect: $fenCorrect, fenIncorrect: $fenIncorrect, inkTarget: $inkTarget, inkSolved: $inkSolved, inkCorrect: $inkCorrect, inkIncorrect: $inkIncorrect, ingTarget: $ingTarget, ingSolved: $ingSolved, ingCorrect: $ingCorrect, ingIncorrect: $ingIncorrect, dinTarget: $dinTarget, dinSolved: $dinSolved, dinCorrect: $dinCorrect, dinIncorrect: $dinIncorrect}';
  }
}
