import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../common/constants.dart';
import '../../../../../common/custom_dialog.dart';
import '../../../../../core/init/extensions.dart';
import '../../../../../models/meeting.dart';
import 'cubit/agenda_box_cubit.dart';

import '../../../../../core/init/locale_keys.g.dart';

class AgendaMeetingDetailDialog extends StatelessWidget {
  final Meeting meeting;
  final AgendaBoxCubit cubit;

  const AgendaMeetingDetailDialog({Key? key, required this.meeting, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String subjectText = meeting.eventName!;
    String dateText = DateFormat.yMMMd('tr_TR').format(meeting.from!).toString();
    String startTimeText = DateFormat('HH.mm').format(meeting.from!).toString();
    String endTimeText = DateFormat('HH.mm').format(meeting.to!).toString();
    String timeDetails = '$startTimeText - $endTimeText';

    return AlertDialog(
      backgroundColor: darkSecondaryColor,
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
                  subjectText,
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Center(
                child: Text("$dateText - $timeDetails",
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: infoColor)),
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          onPressed: () {
            _deleteEvent(context);
          },
          child: const Text('Sil'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Kapat'),
        )
      ],
    );
  }

  void _deleteEvent(BuildContext context) {
    CustomDialog.showDeleteAlertDialog(
        context: context,
        message: "${meeting.eventName} adlı randevu / iş silinecek. Emin "
            "misiniz?",
        onConfirm: () {
          cubit.deleteMeeting(meeting).then((value) {
            CustomDialog.showSnackBar(
              message: LocaleKeys.alerts_delete_success.locale(['Randevu']),
              context: context,
              type: DialogType.success,
            );
          });
        });
  }
}
