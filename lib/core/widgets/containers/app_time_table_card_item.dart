import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/common/helper.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:rehberlik/models/subject.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:rehberlik/views/admin/admin_student_detail/components/student_detail_tab_view/time_table/cubit/time_table_list_cubit.dart';

class AppTimeTableCardItem extends StatelessWidget {
  final VoidCallback onTap;
  final TimeTable timeTable;

  const AppTimeTableCardItem({Key? key, required this.onTap, required this.timeTable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: timeTable.id != null
            ? Container(
                alignment: Alignment.center,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Helper.getTimeDayText(timeTable.startTime)} - ${Helper.getTimeDayText(timeTable.endTime)}",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        _getLessonNameText(lessonID: timeTable.lessonID, context: context),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        _getSubjectName(lessonID: timeTable.lessonID, subjectID: timeTable.subjectID, context: context),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(letterSpacing: 0.3),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(
                width: 100,
              ),
      ),
    );
  }

  String _getLessonNameText({String? lessonID, required BuildContext context}) {
    final lessonList = context.read<TimeTableListCubit>().lessonWithSubjectList;
    if (lessonList != null && lessonID != null) {
      LessonWithSubject? lessonWithSubject = lessonList.findOrNull((element) => element.lesson.id == lessonID);
      if (lessonWithSubject != null) {
        return lessonWithSubject.lesson.lessonName!;
      }
    }
    return "";
  }

  String _getSubjectName({required String? lessonID, required String? subjectID, required BuildContext context}) {
    if (lessonID != null) {
      final lessonList = context.read<TimeTableListCubit>().lessonWithSubjectList;
      if (lessonList != null) {
        LessonWithSubject? lessonWithSubject = lessonList.findOrNull((element) => element.lesson.id == lessonID);
        if (lessonWithSubject != null) {
          if (lessonWithSubject.subjectList != null) {
            Subject? subject = lessonWithSubject.subjectList!.findOrNull((subject) => subject.id == subjectID);
            if (subject != null) {
              return subject.subject!;
            }
          }
        }
      }
    }
    return "";
  }
}
