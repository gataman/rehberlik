part of admin_dashboard_view;

// ignore: must_be_immutable
class AgendaBox extends StatelessWidget {
  MeetingDataSource? _meetingDataSource;

  AgendaBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 400,
      child: Card(
        child: Column(
          children: [
            Text(
              "Randevular - Ajanda",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            BlocBuilder<AgendaBoxCubit, AgendaBoxState>(builder: (context, state) {
              final list = (state as AgendaBoxInitial).meetingList;
              if (list != null) {
                _meetingDataSource = MeetingDataSource(list);
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
                      fontSize: size.width <= 600 ? 7 : 10,
                      color: darkBackColor),
                  onTap: (CalendarTapDetails details) {
                    _showCalendarDialog(context, details);
                  },
                  onViewChanged: (view) {
                    //DateTime startTime = view.visibleDates.first;
                    //DateTime endTime = view.visibleDates.last;

                    //controller.getAllMeetingsWithTime(startTime, endTime);
                  },
                  timeSlotViewSettings: const TimeSlotViewSettings(dateFormat: 'dd', timeFormat: 'HH.mm'),
                  monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment, agendaViewHeight: 200),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showCalendarDialog(BuildContext context, CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      final Meeting meeting = details.appointments![0];
      final AgendaBoxCubit cubit = context.read<AgendaBoxCubit>();

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AgendaMeetingDetailDialog(meeting: meeting, cubit: cubit);
          });
    } else if (details.targetElement == CalendarElement.calendarCell) {
      final cubit = context.read<AgendaBoxCubit>();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AgendaBoxNewEventAlertDialog(
              details: details,
              cubit: cubit,
            );
          });
    }
  }
}
