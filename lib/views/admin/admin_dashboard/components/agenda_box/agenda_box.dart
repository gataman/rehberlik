part of admin_dashboard_view;

// ignore: must_be_immutable
class AgendaBox extends GetView<AdminDashboardController> {
  MeetingDataSource? _meetingDataSource;

  AgendaBox({Key? key}) : super(key: key);

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
            final _list = controller.meetingList.value;
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

                  controller.getAllMeetingsWithTime(startTime, endTime);
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
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AgendaBoxNewEventAlertDialog(details: details);
          });
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
        controller.deleteMeeting(meetings).then((value) {
          Get.back();
          Navigator.of(context).pop();
        });
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }
}
