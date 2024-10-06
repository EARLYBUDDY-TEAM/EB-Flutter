part of '../eb_uikit.dart';

final class EBTime {
  // static final EBTime shared = EBTime();

  static String intToString(int time) {
    if (time <= 0) {
      return '0분';
    }

    final int h = time ~/ 60;
    final String hour = h == 0 ? '' : '$h시간';
    final int m = time % 60;
    final String minute = '$m분';
    return hour == '' ? minute : '$hour $minute';
  }

  static TimeOfDay dateTimeToTimeOfDay(DateTime datetime) {
    return TimeOfDay.fromDateTime(datetime);
  }

  static String toHour(TimeOfDay timeOfDay) {
    String meridiem = timeOfDay.hour < 12 ? '오전' : '오후';
    final m = timeOfDay.minute;
    String minute = m < 10 ? '0$m' : '$m';
    return '$meridiem ${timeOfDay.hour}:$minute';
  }
}
