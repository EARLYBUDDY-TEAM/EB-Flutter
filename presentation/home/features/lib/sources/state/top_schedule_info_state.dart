part of '../../eb_home_feature.dart';

sealed class SealedTopScheduleInfoState {}

final class NoneHomeTopScheduleInfoState extends SealedTopScheduleInfoState
    with EquatableMixin {
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

final class TodayTopScheduleInfoState extends SealedTopScheduleInfoState
    with EquatableMixin {
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
