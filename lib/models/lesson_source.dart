// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class LessonSource {
  String? id;
  String? studentId;
  String? lessonId;
  String? sourcesName;
  int? sort;
  List<dynamic>? subjectList;

  LessonSource({
    this.id,
    required this.studentId,
    required this.lessonId,
    required this.sourcesName,
    this.sort = 0,
    required this.subjectList,
  });

  factory LessonSource.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return LessonSource(
      id: snapshot.id,
      studentId: data?['studentId'],
      lessonId: data?['lessonId'],
      sourcesName: data?['sourcesName'],
      sort: data?['sort'],
      subjectList: data?['subjectList'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "studentId": studentId,
      "lessonId": lessonId,
      "sourcesName": sourcesName,
      "sort": sort,
      "subjectList": subjectList,
    };
  }

  @override
  String toString() {
    return 'Sources(id: $id, studentId: $studentId, lessonId: $lessonId, sourcesName: $sourcesName, sort: $sort, subjectList: $subjectList)';
  }
}
