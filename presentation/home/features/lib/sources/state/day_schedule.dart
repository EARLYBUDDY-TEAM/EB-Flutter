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

  static DaySchedule initWithAllSchedules({
    required List<Schedule> allSchedules,
  }) {
    DayScheduleMap tmpData = {};
    for (var schedule in allSchedules) {
      final day = EBTime.dateTimeToDay(schedule.time);
      if (tmpData.containsKey(day)) {
        tmpData[day]!.add(schedule);
      } else {
        tmpData[day] = [schedule];
      }
    }

    return DaySchedule(data: tmpData);
  }

  List<Schedule> get({required DateTime selectedDay}) {
    final key = EBTime.dateTimeToDay(selectedDay);
    return data.containsKey(key) ? data[key]! : [];
  }

  DaySchedule delete({required Schedule schedule}) {
    final key = EBTime.dateTimeToDay(schedule.time);
    if (data.containsKey(key)) {
      final scheduleList = data[key]!;
      scheduleList.remove(schedule);
    }

    return DaySchedule(data: data);
  }

  bool checkSchedule({required DateTime dateTime}) {
    final key = EBTime.dateTimeToDay(dateTime);
    return data.containsKey(key);
  }
}
