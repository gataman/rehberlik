import 'package:flutter/material.dart';
import 'dart:math';

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

  static String getRandomString(int length) {
    const characters = 'ABCDEFGHIJKLMNPRSTUVYZ123456789';
    // '+-*=?AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }
}
