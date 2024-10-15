part of '../../eb_home_feature.dart';

typedef DayScheduleMap = Map<DateTime, List<Schedule>>;

final class DaySchedule extends Equatable {
  final DayScheduleMap data;

  DaySchedule({DayScheduleMap? data}) : data = data ?? {};

  @override
  List<Object?> get props => [data];

  DaySchedule copyWith({
    DayScheduleMap? data,
  }) {
    return DaySchedule(
      data: data ?? this.data,
    );
  }

  static DaySchedule init({
    required List<Schedule> allSchedules,
  }) {
    DayScheduleMap tmpData = {};
    for (var schedule in allSchedules) {
      final date = schedule.time.toDate();
      if (tmpData.containsKey(date)) {
        tmpData[date]!.add(schedule);
      } else {
        tmpData[date] = [schedule];
      }
    }

    return DaySchedule(data: tmpData);
  }

  List<Schedule> getValue({required DateTime selectedDay}) {
    final key = selectedDay.toDate();
    return data.containsKey(key) ? data[key]! : [];
  }

  List<DateTime> getKeyList() {
    final keyList = data.keys.toList()..sort();
    return keyList;
  }

  DaySchedule delete({required Schedule schedule}) {
    final key = schedule.time.toDate();
    if (data.containsKey(key)) {
      final scheduleList = data[key]!;
      scheduleList.remove(schedule);
    }

    return DaySchedule(data: data);
  }

  bool isExistSchedule({required DateTime dateTime}) {
    final key = dateTime.toDate();
    return data.containsKey(key);
  }
}
