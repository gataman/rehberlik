import '../lesson.dart';
import '../subject.dart';

class LessonWithSubject {
  Lesson lesson;
  List<Subject>? subjectList;

  LessonWithSubject({required this.lesson, this.subjectList});

  @override
  String toString() {
    return 'LessonWithSubject{lesson: $lesson, subjectList: $subjectList}';
  }
}
