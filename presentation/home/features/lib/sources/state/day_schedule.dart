part of '../../eb_home_feature.dart';

typedef DayScheduleMap = Map<DateTime, List<Schedule>>;

final class DaySchedule extends Equatable {
  final DayScheduleMap data;
  final bool reloadTrigger;

  DaySchedule({
    DayScheduleMap? data,
    bool? reloadTrigger,
  })  : data = data ?? {},
        reloadTrigger = reloadTrigger ?? false;

  @override
  List<Object?> get props => [data, reloadTrigger];

  DaySchedule copyWith({
    DayScheduleMap? data,
    bool? reloadTrigger,
  }) {
    return DaySchedule(
      data: data ?? this.data,
      reloadTrigger: reloadTrigger ?? this.reloadTrigger,
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
      if (scheduleList.isEmpty) {
        data.remove(key);
      }
    }

    return DaySchedule(
      data: data,
      reloadTrigger: !reloadTrigger,
    );
  }

  bool isExistSchedule({required DateTime dateTime}) {
    final key = dateTime.toDate();
    return data.containsKey(key);
  }
}
