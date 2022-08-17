import 'package:flutter/material.dart';

class Helper {
  static String getTimeDayText(int? time) {
    if (time != null) {
      int hour = time ~/ 60;
      int minute = time % 60;

      final timeDay = TimeOfDay(hour: hour, minute: minute);

      return "${timeDay.hour.toString().padLeft(2, '0')}.${timeDay.minute.toString().padLeft(2, '0')}";
    } else {
      return "Saat Seçin";
    }
  }
}
