import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rehberlik/common/locator.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:rehberlik/repository/classes_repository.dart';
import 'package:rehberlik/repository/lesson_repository.dart';
import 'package:rehberlik/repository/time_table_repository.dart';
import 'package:rehberlik/common/extensions.dart';

part 'time_table_state.dart';

class TimeTableCubit extends Cubit<TimeTableState> {
  TimeTableCubit() : super(TimeTableState());

  final TimeTableRepository _timeTableRepository =
      locator<TimeTableRepository>();
  final ClassesRepository _classRepository = locator<ClassesRepository>();
  final LessonRepository _lessonRepository = locator<LessonRepository>();

  Map<int, List<TimeTable>>? timeTableList;
  List<LessonWithSubject>? lessonWithSubjectList;
  bool needUpdate = false;
  int selectedClassLevel = 0;

  Future<Map<int, List<TimeTable>>?> fetchTimeTableList(
      {required Student student}) async {
    return await Future.delayed(const Duration(milliseconds: 1), () async {
      final _localList = <TimeTable>[];

      for (var order = 0; order < 4; order++) {
        for (var day = 1; day <= 7; day++) {
          var timeTable =
              TimeTable(studentID: student.id, order: order, day: day);

          _localList.add(timeTable);
        }
      }

      final remoteList =
          await _timeTableRepository.getAll(filters: {'studentID': student.id});

      if (remoteList != null && remoteList.isNotEmpty) {
        for (var _timeTable in remoteList) {
          var findingTimeTable = _localList.findOrNull((element) =>
              element.day == _timeTable.day &&
              element.order == _timeTable.order);
          if (findingTimeTable != null) {
            final index = _localList.indexOf(findingTimeTable);
            _localList[index] = _timeTable;
          }
        }
      }

      await getAllLessonWithSubject(student: student);
      final groupedList = _localList.groupBy((element) => element.order);
      timeTableList = groupedList;
      return groupedList;
    });
  }

  Future<void> getAllLessonWithSubject({required Student student}) async {
    if (student.classID != null) {
      final classes = await _classRepository.get(classID: student.classID!);
      if (classes != null) {
        if (needUpdate) {
          await getAndUpdateList(classes);
          needUpdate = false;
        } else {
          if (selectedClassLevel != classes.classLevel) {
            await getAndUpdateList(classes);
          } else {
            print("Yeni ders listesi yüklemeye gerek yok........");
          }
        }
      }
    }
  }

  Future<void> getAndUpdateList(Classes classes) async {
    final _lessonWithSubjectList = await _lessonRepository
        .getAllWithSubjects(filters: {'classLevel': classes.classLevel});

    lessonWithSubjectList = _lessonWithSubjectList;
    if (classes.classLevel != null) {
      selectedClassLevel = classes.classLevel!;
    }
  }
}
