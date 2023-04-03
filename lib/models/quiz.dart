// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String? id;
  String? quizTitle;
  DateTime? quizDate;

  Quiz({this.id, required this.quizTitle, required this.quizDate});

  factory Quiz.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Quiz(
      id: snapshot.id,
      quizTitle: data?['quizTitle'],
      quizDate: (data?['quizDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "quizTitle": quizTitle,
      "quizDate": quizDate,
    };
  }

  @override
  String toString() => 'Quiz(id: $id, quizTitle: $quizTitle, quizDate: $quizDate)';
}
