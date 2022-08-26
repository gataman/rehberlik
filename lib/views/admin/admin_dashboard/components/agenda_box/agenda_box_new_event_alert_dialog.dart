part of admin_dashboard_view;

class AgendaBoxNewEventAlertDialog extends StatefulWidget {
  final CalendarTapDetails details;

  const AgendaBoxNewEventAlertDialog({Key? key, required this.details})
      : super(key: key);

  @override
  State<AgendaBoxNewEventAlertDialog> createState() =>
      _AgendaBoxNewEventDialogFormState();
}

class _AgendaBoxNewEventDialogFormState
    extends State<AgendaBoxNewEventAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _controller = Get.put(AdminDashboardController());
  late DateTime _startTime;

  late DateTime _endTime;
  late String _dateText;

  @override
  void initState() {
    _startTime = widget.details.date!;
    _endTime = widget.details.date!.add(const Duration(minutes: 60));

    _controller.startTime.value =
        TimeOfDay(hour: _startTime.hour, minute: _startTime.minute);

    _controller.endTime.value =
        TimeOfDay(hour: _endTime.hour, minute: _endTime.minute);

    _dateText = DateFormat("dd.MM.yyyy").format(_startTime);
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
            _dateText,
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
                    margin: const EdgeInsets.only(bottom: defaultPadding / 2),
                    child: const MeetingTypeSelectBox()),
                Center(
                  child: AgendaBoxNewEventFormField(
                      subjectController: _subjectController),
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
  }

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

  String _getTimeStringFormat(TimeOfDay timeOfDay) =>
      "${timeOfDay.hour.toString().padLeft(2, '0')}.${timeOfDay.minute.toString().padLeft(2, '0')}";
}
