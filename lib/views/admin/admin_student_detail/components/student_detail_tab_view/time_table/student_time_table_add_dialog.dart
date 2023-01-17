import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/custom_dialog.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/common/helper.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:rehberlik/models/subject.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:rehberlik/views/admin/admin_student_detail/components/student_detail_tab_view/time_table/cubit/time_table_list_cubit.dart';

class TimeTableAddAlertDialog extends StatefulWidget {
  final TimeTable timeTable;
  final TimeTableListCubit cubit;

  const TimeTableAddAlertDialog({Key? key, required this.timeTable, required this.cubit}) : super(key: key);

  @override
  State<TimeTableAddAlertDialog> createState() => _TimeTableAddAlertDialogState();
}

class _TimeTableAddAlertDialogState extends State<TimeTableAddAlertDialog> {
  List<Subject>? selectedSubjectList;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Center(
        child: Text(
          "Ders ve Konu Ekle",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      content: Column(
        children: [_getNewTimeTableValues(context)],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              size: 16,
              color: Theme.of(context).colorScheme.onError,
            ),
            label: Text(
              'Kapat',
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            )),
        ElevatedButton.icon(
            onPressed: () async {
              await _saveTimeTable(context: context);
            },
            icon: Icon(
              Icons.save,
              size: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            label: Text(widget.timeTable.id == null ? 'Kaydet' : 'Güncelle',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)))
      ],
    );
  }

  //region Set View

  Table _getNewTimeTableValues(BuildContext context) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        TableRow(children: [
          _getSubTitleTextLabel(text: "Başlama Saati"),
          _getSubTitleTextLabel(text: ":"),
          GestureDetector(
            onTap: () async {
              final newTime = await _showTimePicker(context: context, time: widget.timeTable.startTime);

              if (newTime != null) {
                final totalMin = (newTime.hour * 60) + newTime.minute;
                setState(() {
                  widget.timeTable.startTime = totalMin;
                  widget.timeTable.endTime ??= totalMin + 60;
                });
              }
            },
            child: _getSubValueTextLabel(text: Helper.getTimeDayText(widget.timeTable.startTime), type: 1),
          ),
        ]),
        TableRow(children: [
          _getSubTitleTextLabel(text: "Bitiş Saati"),
          _getSubTitleTextLabel(text: ":"),
          GestureDetector(
            onTap: () async {
              final newTime = await _showTimePicker(context: context, time: widget.timeTable.endTime);

              if (newTime != null) {
                final totalMin = (newTime.hour * 60) + newTime.minute;
                setState(() => widget.timeTable.endTime = totalMin);

                //_controller.selectedTimeTable.value!.endTime = totalMin;
                //_controller.selectedTimeTable.refresh();
              }
            },
            child: _getSubValueTextLabel(text: Helper.getTimeDayText(widget.timeTable.endTime), type: 1),
          ),
        ]),
        TableRow(children: [
          _getSubTitleTextLabel(text: "Ders"),
          _getSubTitleTextLabel(text: ":"),
          GestureDetector(
            onTap: () {
              _showLessonDialog(context);
            },
            child: _getSubValueTextLabel(text: _getLessonName(lessonID: widget.timeTable.lessonID), type: 2),
          ),
        ]),
        TableRow(children: [
          _getSubTitleTextLabel(text: "Konu"),
          _getSubTitleTextLabel(text: ":"),
          GestureDetector(
            onTap: () {
              _showSubjectDialog();
            },
            child: _getSubValueTextLabel(
                text: _getSubjectName(lessonID: widget.timeTable.lessonID, subjectID: widget.timeTable.subjectID),
                type: 3),
          ),
        ]),
      ],
    );
  }

  Widget _getSubTitleTextLabel({required String text}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        text,
        style: defaultDialogSubTitleStyle,
      ),
    );
  }

  Widget _getSubValueTextLabel({required String? text, required int type}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        type == 1
            ? text ?? 'Saat Seçiniz'
            : type == 2
                ? text ?? 'Ders Seçiniz'
                : text ?? 'Konu Seçiniz',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Future<TimeOfDay?> _showTimePicker({required BuildContext context, required int? time}) async {
    TimeOfDay selectedTime;

    if (time != null) {
      final hour = time ~/ 60;
      final minute = time % 60;

      selectedTime = TimeOfDay(hour: hour, minute: minute);
    } else {
      selectedTime = const TimeOfDay(hour: 17, minute: 30);
    }

    TimeOfDay? newStartTime = await showTimePicker(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          );
        },
        context: context,
        initialTime: selectedTime);

    return newStartTime;
  }

  //endregion

  //region Lesson Dialog
  void _showLessonDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: darkBackColor,
            scrollable: true,
            title: const Center(
              child: Text(
                "Ders Seçin",
                style: defaultTitleStyle,
              ),
            ),
            content: SizedBox(width: 100, height: 200, child: _getLessonListWiew()),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Kapat'),
              )
            ],
          );
        });
  }

  Widget _getLessonListWiew() {
    final lessonWithSubjectList = widget.cubit.lessonWithSubjectList;
    if (lessonWithSubjectList != null && lessonWithSubjectList.isNotEmpty) {
      return ListView.builder(
          //shrinkWrap: true,
          //physics: const NeverScrollableScrollPhysics(),
          itemCount: lessonWithSubjectList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: () {
                  _selectLesson(lessonWithSubject: lessonWithSubjectList[index]);
                  Navigator.of(context).pop();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white10, width: 0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: darkSecondaryColor,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Text(lessonWithSubjectList[index].lesson.lessonName ?? '',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
            );
          });
    } else {
      return const Text("Lütfen ders ekleyin!");
    }
  }

  void _selectLesson({required LessonWithSubject lessonWithSubject}) {
    setState(() {
      widget.timeTable.lessonID = lessonWithSubject.lesson.id;
      selectedSubjectList = lessonWithSubject.subjectList;
      widget.timeTable.subjectID = null;
    });
  }

//endregion

  //region Subject Dialog
  void _showSubjectDialog() {
    if (widget.timeTable.lessonID != null) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              backgroundColor: darkBackColor,
              scrollable: true,
              title: const Center(
                child: Text(
                  "Konu Seçin",
                  style: defaultTitleStyle,
                ),
              ),
              content: SizedBox(width: 100, height: 200, child: _getSubjectListWiew(selectedSubjectList)),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Kapat',
                    style: TextStyle(color: Theme.of(context).colorScheme.onError),
                  ),
                )
              ],
            );
          });
    } else {
      CustomDialog.showSnackBar(
        message: "Bir hata oluştu!",
        context: context,
        type: DialogType.error,
      );
    }
  }

  _getSubjectListWiew(List<Subject>? subjectList) {
    if (subjectList == null || subjectList.isEmpty) {
      return const Text("Bu derse ait konu eklenmemiş görünüyor. Sistemde bir hata yoksa lütfen konu ekleyiniz.");
    } else {
      return ListView.builder(
          //shrinkWrap: true,
          //physics: const NeverScrollableScrollPhysics(),
          itemCount: subjectList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: () {
                  _selectSubject(selectedSubjectID: subjectList[index].id!);
                  Navigator.of(context).pop();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white10, width: 0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: darkSecondaryColor,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Text(subjectList[index].subject!,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
            );
          });
    }
  }

  void _selectSubject({required String selectedSubjectID}) {
    setState(() {
      widget.timeTable.subjectID = selectedSubjectID;
    });
  }

  Future<void> _saveTimeTable({required BuildContext context}) async {
    var timeTable = widget.timeTable;
    if (timeTable.startTime == null) {
      CustomDialog.showSnackBar(
        message: "Lütfen çalışma başlangıç saatini seçiniz!",
        context: context,
        type: DialogType.warning,
      );
    } else if (timeTable.endTime == null) {
      CustomDialog.showSnackBar(
        message: "Lütfen çalışma bitiş saatini seçiniz!",
        context: context,
        type: DialogType.warning,
      );
    } else if (timeTable.lessonID == null) {
      CustomDialog.showSnackBar(
        message: "Lütfen ders seçiniz!",
        context: context,
        type: DialogType.warning,
      );
    } else if (timeTable.subjectID == null) {
      CustomDialog.showSnackBar(
        message: "Lütfen konu seçiniz!",
        context: context,
        type: DialogType.warning,
      );
    } else {
      if (timeTable.id == null) {
        widget.cubit.addTimeTable(timeTable: timeTable).then((value) {
          CustomDialog.showSnackBar(
            message: "Başarıyla eklendi",
            context: context,
            type: DialogType.success,
          );
          Navigator.of(context).pop();
        }, onError: (e) {
          CustomDialog.showSnackBar(
            message: LocaleKeys.alerts_error.locale([e.toString()]),
            context: context,
            type: DialogType.error,
          );
        });
      } else {
        widget.cubit.updateTimeTable(timeTable: timeTable).then((value) {
          CustomDialog.showSnackBar(
            message: "Başarıyla güncellendi",
            context: context,
            type: DialogType.success,
          );
          Navigator.of(context).pop();
        }, onError: (e) {
          CustomDialog.showSnackBar(
            message: LocaleKeys.alerts_error.locale([e.toString()]),
            context: context,
            type: DialogType.error,
          );
        });
      }
    }
  }

  String? _getLessonName({required String? lessonID}) {
    final lessonList = widget.cubit.lessonWithSubjectList;
    if (lessonList != null && lessonList.isNotEmpty && lessonID != null) {
      LessonWithSubject? lessonWithSubject = lessonList.findOrNull((element) => element.lesson.id == lessonID);
      if (lessonWithSubject != null) {
        return lessonWithSubject.lesson.lessonName;
      }
    }
    return null;
  }

  String? _getSubjectName({required String? lessonID, required String? subjectID}) {
    final lessonList = widget.cubit.lessonWithSubjectList;
    if (lessonList != null && lessonList.isNotEmpty && lessonID != null) {
      LessonWithSubject? lessonWithSubject = lessonList.findOrNull((element) => element.lesson.id == lessonID);
      if (lessonWithSubject != null) {
        if (lessonWithSubject.subjectList != null) {
          Subject? subject = lessonWithSubject.subjectList!.findOrNull((subject) => subject.id == subjectID);
          if (subject != null) {
            return subject.subject;
          }
        }
      }
    }
    return null;
  }

//endregion
}
