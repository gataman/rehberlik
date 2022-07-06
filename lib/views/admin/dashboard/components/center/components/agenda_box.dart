import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/dashboard/components/center/components/meeting.dart';
import 'package:rehberlik/views/admin/dashboard/components/center/components/meeting_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class AgendaBox extends StatefulWidget {
  const AgendaBox({Key? key}) : super(key: key);

  @override
  State<AgendaBox> createState() => _AgendaBoxState();
}

class _AgendaBoxState extends State<AgendaBox> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
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
          const SizedBox(
            height: defaultPadding,
          ),
          SfCalendar(
            view: CalendarView.week,
            dataSource: MeetingDataSource(
              _getDataSource(),
            ),
            showNavigationArrow: true,
            showDatePickerButton: true,
            firstDayOfWeek: 1,
            appointmentTextStyle: TextStyle(
                fontSize: _size.width <= 600 ? 7 : 12, color: Colors.white),
            onTap: (CalendarTapDetails details) {
              _showCalendarDialog(context, details);
            },
            timeSlotViewSettings: const TimeSlotViewSettings(
                dateFormat: 'dd', timeFormat: 'HH.mm'),
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                agendaViewHeight: 200),
          ),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 1));
    meetings.add(Meeting(
        'Ahmet Aslan - Öğrenci', startTime, endTime, primaryColor, false));

    final DateTime startTime2 =
        DateTime(today.year, today.month, today.day, 11);
    final DateTime endTime2 = startTime2.add(const Duration(minutes: 40));

    meetings.add(Meeting('Muhammet Selim - Öğrenci', startTime2, endTime2,
        Colors.redAccent, false));

    final DateTime startTime3 =
        DateTime(today.year, today.month, today.day + 1, 10);
    final DateTime endTime3 = startTime3.add(const Duration(hours: 1));

    meetings.add(Meeting('Ayhan Sofuoğlu - Veli', startTime3, endTime3,
        Colors.deepPurple, false));

    /*
    meetings.add(
      Meeting(
        "Hakan Uzan - Veli",
        DateTime(2022, 6, 27, 14),
        DateTime(2022, 6, 27, 14, 30),
        Colors.redAccent,
        false,
      ),
    );

    meetings.add(
      Meeting(
        "Mustafa Çalışkan - Veli",
        DateTime(2022, 6, 28, 11),
        DateTime(2022, 6, 28, 12),
        Colors.redAccent,
        false,
      ),
    );

    meetings.add(
      Meeting(
        "Hakan Uzan - Veli",
        DateTime(2022, 6, 28, 13),
        DateTime(2022, 6, 28, 13, 30),
        Colors.redAccent,
        false,
      ),
    );

    meetings.add(
      Meeting(
        "Konferans",
        DateTime(2022, 6, 28, 15),
        DateTime(2022, 6, 28, 16, 30),
        Colors.blueAccent,
        false,
      ),
    );

     */
    return meetings;
  }

  void _showCalendarDialog(BuildContext context, CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      final Meeting appointmentDetails = details.appointments![0];
      String _subjectText = appointmentDetails.eventName;
      String _timeDetails = "";
      String _dateText =
          DateFormat.yMMMd('tr_TR').format(appointmentDetails.from).toString();
      String _startTimeText =
          DateFormat('HH.mm').format(appointmentDetails.from).toString();
      String _endTimeText =
          DateFormat('HH.mm').format(appointmentDetails.to).toString();
      if (appointmentDetails.isAllDay) {
        _timeDetails = 'Gün Boyu';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(child: Text("Randevu Detayı")),
              content: SizedBox(
                height: 80,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          _subjectText,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Center(
                        child: Text("$_dateText - $_timeDetails",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12)),
                      )
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Kapat'))
              ],
            );
          });
    } else if (details.targetElement == CalendarElement.calendarCell) {
      // Yeni ekleme button
      const Tooltip(
        message: "Yeni ekle",
        verticalOffset: 48,
        height: 24,
        child: Text("denenmemem"),
      );
      debugPrint("gun:${details.date!.day}");
      debugPrint("ay:${details.date!.month}");

      debugPrint("saat:${details.date!.hour}");
      debugPrint("dakika:${details.date!.minute}");
    }
  }
}
