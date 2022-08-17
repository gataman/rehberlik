import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/custom_dialog.dart';
import 'package:rehberlik/common/helper.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:rehberlik/models/subject.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:rehberlik/views/admin/admin_student_detail/time_table/student_time_table_controller.dart';

class StudentTimeTableAddDialog {
  final StudentTimeTableController _controller;

  StudentTimeTableAddDialog(this._controller);

  //region ShowTimeTableDialog
  void showNewTimeTableDialog(BuildContext context) {
    showDialog(
        //barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Obx(() {
            TimeTable? timeTable = _controller.selectedTimeTable.value;
            debugPrint("Seçilen Time Table : ${timeTable.toString()}");
            if (timeTable != null) {
              return AlertDialog(
                backgroundColor: bgColor,
                scrollable: true,
                title: const Center(
                  child: Text(
                    "Ders ve Konu Ekle",
                    style: defaultTitleStyle,
                  ),
                ),
                content: Column(
                  children: [_getNewTimeTableValues(context, timeTable)],
                ),
                actions: <Widget>[
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.redAccent),
                      onPressed: () {
                        _controller.selectedTimeTable.value!.lessonID = null;
                        _controller.selectedLesson.value = null;
                        Navigator.of(context).pop();
                      },
                      child: const Text('Kapat')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: timeTable.id == null
                              ? Colors.lightGreen
                              : Colors.blueAccent),
                      onPressed: () async {
                        await _saveTimeTable(context: context);
                      },
                      child: Text(timeTable.id == null ? 'Kaydet' : 'Güncelle'))
                ],
              );
            } else {
              return const Center();
            }
          });
        });
  }

  Table _getNewTimeTableValues(BuildContext context, TimeTable timeTable) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        TableRow(children: [
          _getSubTitleTextLabel(text: "Başlama Saati"),
          _getSubTitleTextLabel(text: ":"),
          GestureDetector(
            onTap: () async {
              final newTime = await _showTimePicker(
                  context: context, time: timeTable.startTime);

              if (newTime != null) {
                final totalMin = (newTime.hour * 60) + newTime.minute;
                timeTable.startTime = totalMin;
                timeTable.endTime ??= totalMin + 60;
                _controller.selectedTimeTable.refresh();
              }
            },
            child: _getSubValueTextLabel(
                text: Helper.getTimeDayText(timeTable.startTime), type: 1),
          ),
        ]),
        TableRow(children: [
          _getSubTitleTextLabel(text: "Bitiş Saati"),
          _getSubTitleTextLabel(text: ":"),
          GestureDetector(
            onTap: () async {
              final newTime = await _showTimePicker(
                  context: context,
                  time: _controller.selectedTimeTable.value!.endTime);

              if (newTime != null) {
                final totalMin = (newTime.hour * 60) + newTime.minute;
                _controller.selectedTimeTable.value!.endTime = totalMin;
                _controller.selectedTimeTable.refresh();
              }
            },
            child: _getSubValueTextLabel(
                text: Helper.getTimeDayText(timeTable.endTime), type: 1),
          ),
        ]),
        TableRow(children: [
          _getSubTitleTextLabel(text: "Ders"),
          _getSubTitleTextLabel(text: ":"),
          GestureDetector(
            onTap: () {
              _showLessonDialog(context);
            },
            child: _getSubValueTextLabel(
                text: _getLessonName(lessonID: timeTable.lessonID), type: 2),
          ),
        ]),
        TableRow(children: [
          _getSubTitleTextLabel(text: "Konu"),
          _getSubTitleTextLabel(text: ":"),
          GestureDetector(
            onTap: () {
              _showSubjectDialog(context);
            },
            child: _getSubValueTextLabel(
                text: _getSubjectName(
                    lessonID: timeTable.lessonID,
                    subjectID: timeTable.subjectID),
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
        style: defaultDialogSubValueStyle,
      ),
    );
  }

  Future<TimeOfDay?> _showTimePicker(
      {required BuildContext context, required int? time}) async {
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
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: bgColor,
            scrollable: true,
            title: const Center(
              child: Text(
                "Ders Seçin",
                style: defaultTitleStyle,
              ),
            ),
            content:
                SizedBox(width: 100, height: 200, child: _getLessonListWiew()),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
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
    final _lessonList = _controller.lessonWithSubjectList;
    if (_lessonList.isNotEmpty) {
      return ListView.builder(
          //shrinkWrap: true,
          //physics: const NeverScrollableScrollPhysics(),
          itemCount: _lessonList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _selectLesson(lessonWithSubject: _lessonList[index]);
                Navigator.of(context).pop();
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white10, width: 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                color: secondaryColor,
                elevation: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(_lessonList[index].lesson.lessonName!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400)),
                ),
              ),
            );
          });
    } else {
      return const Text("Lütfen ders ekleyin!");
    }
  }

  void _selectLesson({required LessonWithSubject lessonWithSubject}) {
    _controller.selectedLesson.value = lessonWithSubject;
    _controller.selectedTimeTable.value!.lessonID = lessonWithSubject.lesson.id;
    _controller.selectedTimeTable.value!.subjectID = null;
    _controller.selectedTimeTable.refresh();
  }

//endregion

  //region Subject Dialog
  void _showSubjectDialog(BuildContext context) {
    final selectedLesson = _controller.selectedLesson.value;
    if (selectedLesson != null) {
      showDialog(
          context: context,
          builder: (BuildContext _context) {
            return AlertDialog(
              backgroundColor: bgColor,
              scrollable: true,
              title: const Center(
                child: Text(
                  "Konu Seçin",
                  style: defaultTitleStyle,
                ),
              ),
              content: SizedBox(
                  width: 100,
                  height: 200,
                  child: _getSubjectListWiew(selectedLesson.subjectList)),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Kapat'),
                )
              ],
            );
          });
    } else {
      CustomDialog.showErrorMessage(message: "Lütfen öncelikle ders seçiniz!");
    }
  }

  _getSubjectListWiew(List<Subject>? subjectList) {
    if (subjectList == null || subjectList.isEmpty) {
      return const Text(
          "Bu derse ait konu eklenmemiş görünüyor. Sistemde bir hata yoksa lütfen konu ekleyiniz.");
    } else {
      return ListView.builder(
          //shrinkWrap: true,
          //physics: const NeverScrollableScrollPhysics(),
          itemCount: subjectList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _selectSubject(selectedSubjectID: subjectList[index].id!);
                Navigator.of(context).pop();
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white10, width: 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                color: secondaryColor,
                elevation: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(subjectList[index].subject!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400)),
                ),
              ),
            );
          });
    }
  }

  void _selectSubject({required String selectedSubjectID}) {
    _controller.selectedTimeTable.value!.subjectID = selectedSubjectID;
    _controller.selectedTimeTable.refresh();
  }

  Future<void> _saveTimeTable({required BuildContext context}) async {
    final timeTable = _controller.selectedTimeTable.value;
    if (timeTable != null) {
      //_controller.selectedTimeTable.value = null;
      if (timeTable.startTime == null) {
        CustomDialog.showWarningMessage(
            message: "Lütfen çalışma başlangıç saatini seçiniz!");
      } else if (timeTable.endTime == null) {
        CustomDialog.showWarningMessage(
            message: "Lütfen çalışma bitiş saatini seçiniz!");
      } else if (timeTable.lessonID == null) {
        CustomDialog.showWarningMessage(message: "Lütfen ders seçiniz!");
      } else if (timeTable.subjectID == null) {
        CustomDialog.showWarningMessage(message: "Lütfen konu seçiniz!");
      } else {
        if (timeTable.id == null) {
          var timeTableID =
              await _controller.addTimeTable(timeTable: timeTable);
          timeTable.id = timeTableID;
        } else {
          await _controller.updateTimeTable(timeTable: timeTable);
        }
        Navigator.of(context).pop();

        _controller.timeTableList.refresh();
        CustomDialog.showSuccessMessage(message: "Kayıt başarıyla yapıldı");
      }
    } else {
      CustomDialog.showErrorMessage(
          message: "Seçimde bir hata oluştu. Lütfen tekrar deneyiniz!");
    }
  }

  String? _getLessonName({required String? lessonID}) {
    final _lessonList = _controller.lessonWithSubjectList;
    if (lessonID != null) {
      LessonWithSubject? lessonWithSubject = _lessonList
          .firstWhereOrNull((element) => element.lesson.id == lessonID);
      if (lessonWithSubject != null) {
        return lessonWithSubject.lesson.lessonName;
      }
    }

    return lessonID;
  }

  String? _getSubjectName(
      {required String? lessonID, required String? subjectID}) {
    final _lessonList = _controller.lessonWithSubjectList;
    if (lessonID != null) {
      LessonWithSubject? lessonWithSubject = _lessonList
          .firstWhereOrNull((element) => element.lesson.id == lessonID);
      if (lessonWithSubject != null) {
        if (lessonWithSubject.subjectList != null) {
          Subject? subject = lessonWithSubject.subjectList!
              .firstWhereOrNull((subject) => subject.id == subjectID);
          if (subject != null) {
            return subject.subject;
          }
        }
      }
    }
    return subjectID;
  }

//endregion

}
