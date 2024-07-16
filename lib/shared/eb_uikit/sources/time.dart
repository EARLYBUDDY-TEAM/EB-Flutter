part of 'eb_sources.dart';

class EBTime {
  static final EBTime shared = EBTime();

  String intToString(int time) {
    if (time <= 0) {
      return '0분';
    }

    final int h = time ~/ 60;
    final String hour = h == 0 ? '' : '$h시간';
    final int m = time % 60;
    final String minute = '$m분';
    return hour == '' ? minute : '$hour $minute';
  }
}
