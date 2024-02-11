import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeHelper {
  static TimeOfDay getTimeOfDayFrom(String tod) {
    return TimeOfDay(
      hour: int.parse(tod.split(":")[0]),
      minute: int.parse(tod.split(":")[1]),
    );
  }

  static String getTimeStringFrom(TimeOfDay time) =>
      "${time.hour < 10 ? '0' : ''}${time.hour}:${time.minute < 10 ? '0' : ''}${time.minute}";
}
