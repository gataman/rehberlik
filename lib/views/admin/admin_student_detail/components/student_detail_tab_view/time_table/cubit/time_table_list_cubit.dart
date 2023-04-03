import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../common/extensions.dart';
import '../../../../../../../common/locator.dart';
import '../../../../../../../models/classes.dart';
import '../../../../../../../models/helpers/lesson_with_subject.dart';
import '../../../../../../../models/student.dart';
import '../../../../../../../models/time_table.dart';
import '../../../../../../../repository/classes_repository.dart';
import '../../../../../../../repository/lesson_repository.dart';
import '../../../../../../../repository/time_table_repository.dart';

part 'time_table_list_state.dart';

class TimeTableListCubit extends Cubit<TimeTableListState> {
  TimeTableListCubit() : super(TimeTableListState());

  final TimeTableRepository _timeTableRepository = locator<TimeTableRepository>();
  final ClassesRepository _classRepository = locator<ClassesRepository>();
  final LessonRepository _lessonRepository = locator<LessonRepository>();

  Map<int, List<TimeTable>>? timeTableList;
  List<LessonWithSubject>? lessonWithSubjectList;
  bool needUpdate = false;
  int selectedClassLevel = 0;

  Future<Map<int, List<TimeTable>>?> fetchTimeTableList({required Student student}) async {
    return await Future.delayed(const Duration(milliseconds: 1), () async {
      final localList = <TimeTable>[];

      for (var order = 0; order < 4; order++) {
        for (var day = 1; day <= 7; day++) {
          var timeTable = TimeTable(studentID: student.id, order: order, day: day);

          localList.add(timeTable);
        }
      }

      final remoteList = await _timeTableRepository.getAll(filters: {'studentID': student.id});

      if (remoteList != null && remoteList.isNotEmpty) {
        for (var timeTable in remoteList) {
          var findingTimeTable =
              localList.findOrNull((element) => element.day == timeTable.day && element.order == timeTable.order);
          if (findingTimeTable != null) {
            final index = localList.indexOf(findingTimeTable);
            localList[index] = timeTable;
          }
        }
      }
      final groupedList = localList.groupBy((element) => element.order);
      timeTableList = groupedList;
      await getAllLessonWithSubject(student: student);
      return timeTableList;
    });
  }

  Future<void> getAllLessonWithSubject({required Student student}) async {
    final classes = await _classRepository.get(classID: student.classID!);
    if (classes != null) {
      await getAndUpdateList(classes);
    }
    /*
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

     */
  }

  Future<void> getAndUpdateList(Classes classes) async {
    final list = await _lessonRepository.getAllWithSubjects(filters: {'classLevel': classes.classLevel});

    lessonWithSubjectList = list;
    if (classes.classLevel != null) {
      selectedClassLevel = classes.classLevel!;
    }

    _refreshList();
  }

  Future<String?> addTimeTable({required TimeTable timeTable}) async {
    final timeTableID = await _timeTableRepository.add(object: timeTable);
    timeTable.id = timeTableID;
    _refreshList();
    return timeTableID;
  }

  Future<void> updateTimeTable({required TimeTable timeTable}) {
    return _timeTableRepository.update(object: timeTable).then((value) {
      _refreshList();
    });
  }

  void _refreshList() {
    emit(TimeTableListState(
        isLoading: false, timeTableList: timeTableList, lessonWithSubjectList: lessonWithSubjectList));
  }
}
