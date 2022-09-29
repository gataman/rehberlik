part of admin_dashboard_view;

class AgendaBoxNewEventAlertDialog extends StatefulWidget {
  final CalendarTapDetails details;
  final AgendaBoxCubit cubit;

  const AgendaBoxNewEventAlertDialog({Key? key, required this.details, required this.cubit}) : super(key: key);

  @override
  State<AgendaBoxNewEventAlertDialog> createState() => _AgendaBoxNewEventDialogFormState();
}

class _AgendaBoxNewEventDialogFormState extends State<AgendaBoxNewEventAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  late String _dateText;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late DateTime startDate;
  late DateTime endDate;
  int meetingTypeIndex = 0;

  @override
  void initState() {
    startDate = widget.details.date ?? DateTime.now();
    endDate = startDate.add(const Duration(minutes: 60));
    startTime = TimeOfDay(hour: startDate.hour, minute: startDate.minute);
    endTime = TimeOfDay(hour: endDate.hour, minute: endDate.minute);
    _dateText = DateFormat("dd.MM.yyyy").format(startDate);
    super.initState();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Center(
          child: Column(
        children: [
          Text(
            "Yeni Randevu / İş Ekle",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            _dateText,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      )),
      content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: defaultPadding / 2),
                child: MeetingTypeSelectBox(
                  onChanged: (index) {
                    meetingTypeIndex = index;
                  },
                ),
              ),
              Center(
                child: AgendaBoxNewEventFormField(subjectController: _subjectController),
              ),
              Container(
                margin: const EdgeInsets.only(top: defaultPadding),
                child: Table(
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  children: [
                    _getStartTimeText(context),
                    _getEndTimeText(context),
                  ],
                ),
              ),
            ],
          )),
      actions: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Kapat', style: TextStyle(color: Theme.of(context).colorScheme.onError))),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.tertiary),
            onPressed: () {
              if (_saveEvent()) {
                Navigator.of(context).pop();
              }
            },
            child: Text('Kaydet',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                )))
      ],
    );
  }

  TableRow _getStartTimeText(BuildContext context) {
    return TableRow(children: [
      SizedBox(height: 40, child: Text("Başlangıç Saati", style: Theme.of(context).textTheme.labelLarge)),
      const Text(":", style: defaultInfoTitle),
      GestureDetector(
        onTap: () async {
          TimeOfDay? newStartTime = await showTimePicker(
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child ?? Container(),
                );
              },
              context: context,
              initialTime: startTime);

          if (newStartTime == null) return;

          setState(() {
            startTime = newStartTime;
            endTime = TimeOfDay(hour: newStartTime.hour + 1, minute: newStartTime.minute);
          });
        },
        child: Text(_getTimeStringFormat(startTime)),
      ),
    ]);
  }

  TableRow _getEndTimeText(BuildContext context) {
    return TableRow(children: [
      Text("Bitiş Saati", style: Theme.of(context).textTheme.labelLarge),
      const Text(":", style: defaultInfoTitle),
      GestureDetector(
        onTap: () async {
          TimeOfDay? newEndTime = await showTimePicker(
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child ?? Container(),
                );
              },
              context: context,
              initialTime: endTime);
          if (newEndTime == null) return;

          if ((newEndTime.hour * 60) + newEndTime.minute <= (startTime.hour * 60) + startTime.minute) {
            CustomDialog.showSnackBar(
                context: context,
                message: "Bitiş saati, başlangıç saatinden önce "
                    "olamaz!",
                type: DialogType.warning);
            return;
          }

          setState(() {
            endTime = newEndTime;
          });
        },
        child: Text(_getTimeStringFormat(endTime)),
      ),
    ]);
  }

  bool _saveEvent() {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return false;
      }

      DateTime newStartTime =
          DateTime(startDate.year, startDate.month, startDate.day, startTime.hour, startTime.minute);

      DateTime newEndTime = DateTime(startDate.year, startDate.month, startDate.day, endTime.hour, endTime.minute);

      widget.cubit.addMeeting(
          Meeting(eventName: _subjectController.text, from: newStartTime, to: newEndTime, type: meetingTypeIndex));

      return true;
    } else {
      return false;
    }
  }

  String _getTimeStringFormat(TimeOfDay timeOfDay) =>
      "${timeOfDay.hour.toString().padLeft(2, '0')}.${timeOfDay.minute.toString().padLeft(2, '0')}";
}
