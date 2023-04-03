// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../common/constants.dart';
import '../../../../../models/meeting.dart';
import 'agenda_box_new_event_alert_dialog.dart';
import 'agenda_meeting_detail_dialog.dart';
import 'cubit/agenda_box_cubit.dart';
import 'meeting_data_source.dart';

class AgendaBox extends StatelessWidget {
  const AgendaBox({Key? key}) : super(key: key);

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

              MeetingDataSource? meetingDataSource = MeetingDataSource(list);

              return Expanded(
                child: SfCalendar(
                  view: CalendarView.week,
                  dataSource: meetingDataSource,
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
