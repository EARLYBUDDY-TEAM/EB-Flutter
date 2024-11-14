part of '../eb_uikit.dart';

enum EBDay {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

extension TimeOfDayExtension on TimeOfDay {
  int toInt() {
    return (hour * 60) + minute;
  }

  CompareDateResult compareTo(TimeOfDay other) {
    final myTime = toInt();
    final otherTime = other.toInt();

    if (myTime < otherTime) {
      return CompareDateResult.right;
    } else if (myTime > otherTime) {
      return CompareDateResult.left;
    } else {
      return CompareDateResult.same;
    }
  }
}

extension EBTime on DateTime {
  DateTime toDate() {
    return DateTime(year, month, day);
  }

  String addZeroToMonth() {
    final monthString = (1 <= (month / 10)) ? "$month" : "0$month";
    return monthString;
  }

  String addZeroToDay() {
    final dayString = (1 <= (day / 10)) ? "$day" : "0$day";
    return dayString;
  }

  String addZeroToHour() {
    final hourString = (1 <= (hour / 10)) ? "$hour" : "0$hour";
    return hourString;
  }

  String addZeroToMinute() {
    final minuteString = (1 <= (minute / 10)) ? "$minute" : "0$minute";
    return minuteString;
  }

  String toMeridiem() {
    final meridiem = hour < 12 ? '오전' : '오후';
    return meridiem;
  }

  static CompareDateResult compare({
    required DateTime left,
    required DateTime right,
  }) {
    final compareResult = left.compareTo(right);

    switch (compareResult) {
      case < 0:
        return CompareDateResult.right;
      case > 0:
        return CompareDateResult.left;
      default:
        return CompareDateResult.same;
    }
  }

  static CompareDateResult compareDate({
    required DateTime left,
    required DateTime right,
  }) {
    final compareResult = left.toDate().compareTo(right.toDate());

    switch (compareResult) {
      case < 0:
        return CompareDateResult.right;
      case > 0:
        return CompareDateResult.left;
      default:
        return CompareDateResult.same;
    }
  }

  static String intSecToString(int sec) {
    if (sec < 60) {
      return '0분';
    }

    final int m = sec ~/ 60;
    final String minute = "$m분";
    return minute;
  }

  static String intMinuteToString(int min) {
    if (min <= 0) {
      return '0분';
    }

    final int h = min ~/ 60;
    final String hour = h == 0 ? '' : '$h시간';
    final int m = min % 60;
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

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

enum CompareDateResult {
  same,
  left,
  right,
}

enum EBLocale {
  ko_KR,
  en_US,
}
