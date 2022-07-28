import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/meetings.dart';
import 'package:rehberlik/views/admin/dashboard/admin_dashboard_controller.dart';
import 'package:rehberlik/views/admin/dashboard/components/center/components/meeting_data_source.dart';
import 'package:rehberlik/views/admin/dashboard/components/meeting_type_select_box.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class AgendaBox extends StatefulWidget {
  AgendaBox({Key? key}) : super(key: key);

  @override
  State<AgendaBox> createState() => _AgendaBoxState();
}

class _AgendaBoxState extends State<AgendaBox> {
  final _controller = Get.put(AdminDashboardController());
  final _subjectController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  MeetingDataSource? _meetingDataSource;

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      height: 400,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.white10),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Randevular - Ajanda",
            style: TextStyle(fontSize: 16),
          ),
          const Divider(),
          Obx(() {
            final _list = _controller.meetingList.value;
            if (_list != null) {
              _meetingDataSource = MeetingDataSource(_list);
            }

            return Expanded(
              child: SfCalendar(
                view: CalendarView.week,
                dataSource: _meetingDataSource,
                showNavigationArrow: true,
                showDatePickerButton: true,
                firstDayOfWeek: 1,
                appointmentTextStyle: TextStyle(
                    letterSpacing: -0.2,
                    fontWeight: FontWeight.w500,
                    fontSize: _size.width <= 600 ? 7 : 10,
                    color: bgColor),
                onTap: (CalendarTapDetails details) {
                  _showCalendarDialog(context, details);
                },
                onViewChanged: (view) {
                  DateTime startTime = view.visibleDates.first;
                  DateTime endTime = view.visibleDates.last;

                  _controller.getAllMeetingsWithTime(startTime, endTime);
                },
                timeSlotViewSettings: const TimeSlotViewSettings(
                    dateFormat: 'dd', timeFormat: 'HH.mm'),
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                    agendaViewHeight: 200),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showCalendarDialog(BuildContext context, CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      final Meetings meetings = details.appointments![0];
      _showEventDetailDialog(context, meetings);
    } else if (details.targetElement == CalendarElement.calendarCell) {
      _showNewEventDialog(context, details);
    }
  }

  void _showEventDetailDialog(BuildContext context, Meetings meetings) {
    String _subjectText = meetings.eventName!;
    String _dateText =
        DateFormat.yMMMd('tr_TR').format(meetings.from!).toString();
    String _startTimeText =
        DateFormat('HH.mm').format(meetings.from!).toString();
    String _endTimeText = DateFormat('HH.mm').format(meetings.to!).toString();
    String _timeDetails = '$_startTimeText - $_endTimeText';

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: secondaryColor,
            title: const Center(
                child: Text(
              "Randevu / İş Detayı",
              style: defaultTitleStyle,
            )),
            content: SizedBox(
              height: 80,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Text(
                        _subjectText,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Center(
                      child: Text("$_dateText - $_timeDetails",
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: infoColor)),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                onPressed: () {
                  _deleteEvent(meetings, context);
                },
                child: const Text('Sil'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Kapat'),
              )
            ],
          );
        });
  }

  void _deleteEvent(Meetings meetings, BuildContext context) {
    Get.defaultDialog(
      title: "Uyarı",
      middleText:
          "${meetings.eventName} adlı randevu / iş silinecek. Emin misiniz?",
      contentPadding: const EdgeInsets.all(defaultPadding),
      onConfirm: () {
        _controller.deleteMeeting(meetings).then((value) {
          Get.back();
          Navigator.of(context).pop();
        });
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }

  void _showNewEventDialog(BuildContext context, CalendarTapDetails details) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final _startTime = details.date!;
          final _endTime = details.date!.add(const Duration(minutes: 60));
          _controller.startTime.value =
              TimeOfDay(hour: _startTime.hour, minute: _startTime.minute);
          _controller.endTime.value =
              TimeOfDay(hour: _endTime.hour, minute: _endTime.minute);
          String dateTxt = DateFormat("dd.MM.yyyy").format(_startTime);

          return AlertDialog(
            backgroundColor: bgColor,
            scrollable: true,
            title: Center(
                child: Column(
              children: [
                const Text(
                  "Yeni Randevu / İş Ekle",
                  style: defaultTitleStyle,
                ),
                Text(
                  dateTxt,
                  style: const TextStyle(color: Colors.teal, fontSize: 12),
                ),
              ],
            )),
            content: Form(
                key: _formKey,
                child: Obx(() {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          margin:
                              const EdgeInsets.only(bottom: defaultPadding / 2),
                          child: MeetingTypeSelectBox()),
                      Center(
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return "Lütfen konu yazınız!";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          controller: _subjectController,
                          decoration: const InputDecoration(
                            hintText: "Randevu Konusu",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: defaultPadding),
                        child: Table(
                          defaultColumnWidth: const IntrinsicColumnWidth(),
                          children: [
                            if (_controller.startTime.value != null)
                              _getStartTimeText(context),
                            if (_controller.endTime.value != null)
                              _getEndTimeText(context),
                          ],
                        ),
                      ),
                    ],
                  );
                })),
            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Kapat')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
                  onPressed: () {
                    if (_saveEvent(_startTime, _endTime)) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Kaydet'))
            ],
          );
        });
  }

  String _getTimeStringFormat(TimeOfDay timeOfDay) =>
      "${timeOfDay.hour.toString().padLeft(2, '0')}.${timeOfDay.minute.toString().padLeft(2, '0')}";

  TableRow _getStartTimeText(BuildContext context) {
    return TableRow(children: [
      const SizedBox(
          height: 40, child: Text("Başlangıç Saati", style: defaultInfoTitle)),
      const Text(":", style: defaultInfoTitle),
      GestureDetector(
        onTap: () async {
          TimeOfDay? newStartTime = await showTimePicker(
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child ?? Container(),
                );
              },
              context: context,
              initialTime: _controller.startTime.value!);
          debugPrint("New StartTime : ${newStartTime}");
          if (newStartTime == null) return;

          _controller.startTime.value = newStartTime;
          _controller.endTime.value = TimeOfDay(
              hour: newStartTime.hour + 1, minute: newStartTime.minute);
        },
        child: Text(_getTimeStringFormat(_controller.startTime.value!)),
      ),
    ]);
  }

  TableRow _getEndTimeText(BuildContext context) {
    return TableRow(children: [
      const Text("Bitiş Saati", style: defaultInfoTitle),
      const Text(":", style: defaultInfoTitle),
      GestureDetector(
        onTap: () async {
          TimeOfDay? newEndTime = await showTimePicker(
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child ?? Container(),
                );
              },
              context: context,
              initialTime: _controller.endTime.value!);
          if (newEndTime == null) return;

          if ((newEndTime.hour * 60) + newEndTime.minute <=
              (_controller.startTime.value!.hour * 60) +
                  _controller.startTime.value!.minute) {
            Get.snackbar(
              "Hata",
              "Bitiş saati, başlangıç saatinden önce olamaz!",
              colorText: secondaryColor,
              backgroundColor: infoColor,
            );
            return;
          }

          _controller.endTime.value = newEndTime;
        },
        child: Text(_getTimeStringFormat(_controller.endTime.value!)),
      ),
    ]);
  }

  bool _saveEvent(DateTime startTime, DateTime endTime) {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return false;
      }

      if (_controller.startTime.value != null &&
          _controller.endTime.value != null) {
        DateTime newStartTime = DateTime(
            startTime.year,
            startTime.month,
            startTime.day,
            _controller.startTime.value!.hour,
            _controller.startTime.value!.minute);

        DateTime newEndTime = DateTime(
            startTime.year,
            startTime.month,
            startTime.day,
            _controller.endTime.value!.hour,
            _controller.endTime.value!.minute);

        _controller.addMeeting(Meetings(
            eventName: _subjectController.text,
            from: newStartTime,
            to: newEndTime,
            type: _controller.meetingTypeIndex.value));
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
