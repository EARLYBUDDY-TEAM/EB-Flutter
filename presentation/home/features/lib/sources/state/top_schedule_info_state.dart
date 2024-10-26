part of '../../eb_home_feature.dart';

sealed class SealedTopScheduleInfoState extends Equatable {
  static SealedTopScheduleInfoState init({
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
        return TodayTopScheduleInfoState(nextSchedulePath: nextSchedule);
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
      return NoneTopScheduleInfoState();
    } else {
      final upcomingScheduleList =
          daySchedule.getValue(selectedDay: upcomingDate);
      final upcomingSchedule = upcomingScheduleList.firstOrNull;
      return NoneTopScheduleInfoState(
        upcomingSchedule: upcomingSchedule?.schedule,
      );
    }
  }
}

final class NoneTopScheduleInfoState extends SealedTopScheduleInfoState {
  final Schedule? upcomingSchedule;

  NoneTopScheduleInfoState({
    this.upcomingSchedule,
  });

  @override
  List<Object?> get props => [upcomingSchedule];

  NoneTopScheduleInfoState copyWith({
    Schedule? Function()? upcomingSchedule,
  }) {
    return NoneTopScheduleInfoState(
      upcomingSchedule: (upcomingSchedule != null)
          ? upcomingSchedule()
          : this.upcomingSchedule,
    );
  }
}

final class TodayTopScheduleInfoState extends SealedTopScheduleInfoState {
  final SchedulePath nextSchedulePath;

  TodayTopScheduleInfoState({required this.nextSchedulePath});

  @override
  List<Object?> get props => [nextSchedulePath];

  TodayTopScheduleInfoState copyWith({SchedulePath? nextSchedulePath}) {
    return TodayTopScheduleInfoState(
      nextSchedulePath: nextSchedulePath ?? this.nextSchedulePath,
    );
  }
}
