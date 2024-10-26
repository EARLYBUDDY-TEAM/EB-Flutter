part of '../../eb_home_feature.dart';

typedef DayScheduleMap = Map<DateTime, List<SchedulePath>>;

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
    required List<SchedulePath> allSchedules,
  }) {
    DayScheduleMap tmpData = {};
    for (var schedulePath in allSchedules) {
      final date = schedulePath.schedule.time.toDate();
      if (tmpData.containsKey(date)) {
        tmpData[date]!.add(schedulePath);
      } else {
        tmpData[date] = [schedulePath];
      }
    }

    return DaySchedule(data: tmpData);
  }

  List<SchedulePath> getValue({required DateTime selectedDay}) {
    final key = selectedDay.toDate();
    return data.containsKey(key) ? data[key]! : [];
  }

  List<DateTime> getKeyList() {
    final keyList = data.keys.toList()..sort();
    return keyList;
  }

  DaySchedule delete({required SchedulePath schedulePath}) {
    final key = schedulePath.schedule.time.toDate();
    if (data.containsKey(key)) {
      final scheduleList = data[key]!;
      scheduleList.remove(schedulePath);
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
