part of '../../eb_home_feature.dart';

sealed class SealedTopScheduleState extends Equatable {
  static SealedTopScheduleState init({
    required DaySchedule daySchedule,
  }) {
    final today = DateTime.now().toDate();
    final todaySchedulePathList = daySchedule.getValue(selectedDay: today);

    if (todaySchedulePathList.isNotEmpty) {
      SchedulePath? nextSchedule;
      final now = DateTime.now();
      for (var todaySchedulePath in todaySchedulePathList) {
        final compareResult = EBTime.compare(
          left: now,
          right: todaySchedulePath.schedule.time,
        );
        if ((compareResult == CompareDateResult.same) ||
            (compareResult == CompareDateResult.right)) {
          nextSchedule = todaySchedulePath;
          break;
        }
      }
      if (nextSchedule != null) {
        return TodayTopScheduleState(nextSchedulePath: nextSchedule);
      }
    }

    final dateList = daySchedule.getKeyList();
    final nextDay = today.add(const Duration(days: 1));
    DateTime? upcomingDate;
    for (var keyDate in dateList) {
      final compareResult = EBTime.compareDate(left: nextDay, right: keyDate);
      if ((compareResult == CompareDateResult.same) ||
          (compareResult == CompareDateResult.right)) {
        upcomingDate = keyDate;
        break;
      }
    }
    if (upcomingDate == null) {
      return NoneTopScheduleState();
    } else {
      final upcomingScheduleList =
          daySchedule.getValue(selectedDay: upcomingDate);
      final upcomingSchedule = upcomingScheduleList.firstOrNull;
      return NoneTopScheduleState(
        upcomingSchedule: upcomingSchedule?.schedule,
      );
    }
  }
}

final class NoneTopScheduleState extends SealedTopScheduleState {
  final Schedule? upcomingSchedule;

  NoneTopScheduleState({
    this.upcomingSchedule,
  });

  @override
  List<Object?> get props => [upcomingSchedule];

  NoneTopScheduleState copyWith({
    Schedule? Function()? upcomingSchedule,
  }) {
    return NoneTopScheduleState(
      upcomingSchedule: (upcomingSchedule != null)
          ? upcomingSchedule()
          : this.upcomingSchedule,
    );
  }
}

final class TodayTopScheduleState extends SealedTopScheduleState {
  final SchedulePath nextSchedulePath;

  TodayTopScheduleState({required this.nextSchedulePath});

  @override
  List<Object?> get props => [nextSchedulePath];

  TodayTopScheduleState copyWith({SchedulePath? nextSchedulePath}) {
    return TodayTopScheduleState(
      nextSchedulePath: nextSchedulePath ?? this.nextSchedulePath,
    );
  }
}
