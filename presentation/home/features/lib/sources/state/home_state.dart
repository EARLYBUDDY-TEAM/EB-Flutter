part of '../../eb_home_feature.dart';

final class HomeState extends Equatable {
  final HomeStatus status;
  final DaySchedule daySchedule;
  final CalendarState calendarState;
  final SealedTopScheduleInfoState topScheduleInfoState;
  final BottomScheduleListState bottomScheduleListState;

  HomeState({
    HomeStatus? status,
    DaySchedule? daySchedule,
    CalendarState? calendarState,
    SealedTopScheduleInfoState? topScheduleInfoState,
    BottomScheduleListState? bottomScheduleListState,
  })  : status = status ?? const HomeStatus(),
        daySchedule = daySchedule ?? DaySchedule(),
        calendarState = calendarState ?? CalendarState(),
        topScheduleInfoState =
            topScheduleInfoState ?? NoneTopScheduleInfoState(),
        bottomScheduleListState =
            bottomScheduleListState ?? BottomScheduleListState();

  @override
  List<Object?> get props => [
        status,
        daySchedule,
        calendarState,
        topScheduleInfoState,
        bottomScheduleListState,
      ];

  HomeState copyWith({
    HomeStatus? status,
    DaySchedule? daySchedule,
    CalendarState? calendarState,
    SealedTopScheduleInfoState? topScheduleInfoState,
    BottomScheduleListState? bottomScheduleListState,
  }) =>
      HomeState(
        status: status ?? this.status,
        daySchedule: daySchedule ?? this.daySchedule,
        calendarState: calendarState ?? this.calendarState,
        topScheduleInfoState: topScheduleInfoState ?? this.topScheduleInfoState,
        bottomScheduleListState:
            bottomScheduleListState ?? this.bottomScheduleListState,
      );
}
