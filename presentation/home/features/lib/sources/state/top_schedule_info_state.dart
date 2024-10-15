part of '../../eb_home_feature.dart';

sealed class SealedTopScheduleInfoState extends Equatable {
  static SealedTopScheduleInfoState init({
    required DaySchedule daySchedule,
  }) {
    final today = DateTime.now().toDate();
    final todayScheduleList = daySchedule.getValue(selectedDay: today);

    if (todayScheduleList.isNotEmpty) {
      Schedule? nextSchedule;
      final now = DateTime.now();
      for (var todaySchedule in todayScheduleList) {
        final compareResult = EBTime.compare(
          left: now,
          right: todaySchedule.time,
        );
        if ((compareResult == CompareDateResult.same) ||
            (compareResult == CompareDateResult.right)) {
          nextSchedule = todaySchedule;
          break;
        }
      }
      if (nextSchedule != null) {
        return TodayTopScheduleInfoState(nextSchedule: nextSchedule);
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
      return NoneHomeTopScheduleInfoState();
    } else {
      final upcomingScheduleList =
          daySchedule.getValue(selectedDay: upcomingDate);
      final upcomingSchedule = upcomingScheduleList.firstOrNull;
      return NoneHomeTopScheduleInfoState(upcomingSchedule: upcomingSchedule);
    }
  }
}

final class NoneHomeTopScheduleInfoState extends SealedTopScheduleInfoState {
  final Schedule? upcomingSchedule;

  NoneHomeTopScheduleInfoState({
    this.upcomingSchedule,
  });

  @override
  List<Object?> get props => [upcomingSchedule];

  NoneHomeTopScheduleInfoState copyWith({
    Schedule? upcomingSchedule,
  }) {
    return NoneHomeTopScheduleInfoState(
      upcomingSchedule: upcomingSchedule ?? this.upcomingSchedule,
    );
  }
}

final class TodayTopScheduleInfoState extends SealedTopScheduleInfoState {
  final Schedule nextSchedule;

  TodayTopScheduleInfoState({Schedule? nextSchedule})
      : nextSchedule = nextSchedule ?? Schedule();

  @override
  List<Object?> get props => [nextSchedule];

  TodayTopScheduleInfoState copyWith({Schedule? nextSchedule}) {
    return TodayTopScheduleInfoState(
      nextSchedule: nextSchedule ?? this.nextSchedule,
    );
  }
}
