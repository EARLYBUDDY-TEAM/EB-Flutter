part of '../../../home_feature.dart';

typedef DayScheduleMap = Map<DateTime, List<SchedulePath>>;

final class DaySchedule extends Equatable {
  final DayScheduleMap data;
  final bool reloadTrigger;
  final SchedulePath? closeTodaySchedulePath;

  DaySchedule({
    DayScheduleMap? data,
    bool? reloadTrigger,
    SchedulePath? closeTodaySchedulePath,
  })  : data = data ?? {},
        reloadTrigger = reloadTrigger ?? false,
        closeTodaySchedulePath = closeTodaySchedulePath;

  @override
  List<Object?> get props => [data, reloadTrigger];

  DaySchedule copyWith({
    DayScheduleMap? data,
    bool? reloadTrigger,
    SchedulePath? Function()? closeTodaySchedulePath,
  }) {
    return DaySchedule(
      data: data ?? this.data,
      reloadTrigger: reloadTrigger ?? this.reloadTrigger,
      closeTodaySchedulePath: (closeTodaySchedulePath != null)
          ? closeTodaySchedulePath()
          : this.closeTodaySchedulePath,
    );
  }

  static DaySchedule init({
    required List<SchedulePath> allSchedules,
  }) {
    var dayScheduleMap = _getDayScheduleMap(allSchedules);
    dayScheduleMap = _orderTodayDaySchedule(dayScheduleMap);
    final closeTodaySchedulePath = _getCloseTodaySchedulePath(dayScheduleMap);

    return DaySchedule(
      data: dayScheduleMap,
      closeTodaySchedulePath: closeTodaySchedulePath,
    );
  }

  static DayScheduleMap _orderTodayDaySchedule(DayScheduleMap dayScheduleMap) {
    final now = DateTime.now();
    final todayKey = now.toDate();

    if (!dayScheduleMap.containsKey(todayKey)) {
      return dayScheduleMap;
    }

    final todayScheduleList = dayScheduleMap[todayKey]!;
    if (todayScheduleList.isEmpty) {
      return dayScheduleMap;
    }

    int? index;
    for (var i = 0; i < todayScheduleList.length; i++) {
      final currentSchedule = todayScheduleList[i];
      final compareResult =
          EBTime.compare(left: now, right: currentSchedule.schedule.time);
      if ((compareResult == CompareDateResult.same) ||
          (compareResult == CompareDateResult.right)) {
        index = i;
        break;
      }
    }

    if ((index == null) || (index == 0)) {
      return dayScheduleMap;
    }

    final list1 = todayScheduleList.sublist(index, todayScheduleList.length);
    final list2 = todayScheduleList.sublist(0, index);

    final newTodayScheduleList = list1 + list2;
    dayScheduleMap[todayKey] = newTodayScheduleList;

    return dayScheduleMap;
  }

  static DayScheduleMap _getDayScheduleMap(
    List<SchedulePath> allSchedules,
  ) {
    DayScheduleMap tmpData = {};
    for (var schedulePath in allSchedules) {
      final date = schedulePath.schedule.time.toDate();
      if (tmpData.containsKey(date)) {
        tmpData[date]!.add(schedulePath);
      } else {
        tmpData[date] = [schedulePath];
      }
    }

    return tmpData;
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

  static SchedulePath? _getCloseTodaySchedulePath(
    DayScheduleMap dayScheduleMap,
  ) {
    final now = DateTime.now().toDate();
    final todaySchedulePathList = dayScheduleMap[now];
    if (todaySchedulePathList == null) {
      return null;
    }

    SchedulePath? closeSchedulePath;

    for (var schedulePath in todaySchedulePathList) {
      final compareResult =
          EBTime.compare(left: now, right: schedulePath.schedule.time);
      if (compareResult != CompareDateResult.left) {
        closeSchedulePath = schedulePath;
        break;
      }
    }

    return closeSchedulePath;
  }
}
