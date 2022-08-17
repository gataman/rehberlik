import 'package:cloud_firestore/cloud_firestore.dart';

class TrialExam {
  String? id;
  String? examName;
  String? examCode;
  int? classLevel;
  int examType;
  DateTime? examDate;

  TrialExam(
      {this.id,
      required this.examName,
      required this.examCode,
      required this.classLevel,
      required this.examDate,
      this.examType = 1});

  factory TrialExam.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TrialExam(
      id: snapshot.id,
      examName: data?['examName'],
      examCode: data?['examCode'],
      classLevel: data?['classLevel'],
      examType: data?['examType'],
      examDate: (data?['examDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "examName": examName,
      "examCode": examCode,
      "classLevel": classLevel,
      "examType": examType,
      "examDate": examDate,
    };
  }

  @override
  String toString() {
    return 'TrialExam{id: $id, examName: $examName, examCode: $examCode, classLevel: $classLevel, examType: $examType, examDate: $examDate}';
  }
}
