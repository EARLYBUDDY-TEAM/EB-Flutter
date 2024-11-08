part of '../../home_feature.dart';

final class HomeState extends Equatable {
  final HomeStatus status;
  final DaySchedule daySchedule;
  final CalendarState calendarState;
  final SealedTopScheduleState topScheduleInfoState;
  final MiddleTransportInfoState middleTransportInfoState;
  final BottomScheduleListState bottomScheduleListState;

  HomeState({
    HomeStatus? status,
    DaySchedule? daySchedule,
    CalendarState? calendarState,
    SealedTopScheduleState? topScheduleInfoState,
    MiddleTransportInfoState? middleTransportInfoState,
    BottomScheduleListState? bottomScheduleListState,
  })  : status = status ?? const HomeStatus(),
        daySchedule = daySchedule ?? DaySchedule(),
        calendarState = calendarState ?? CalendarState(),
        topScheduleInfoState = topScheduleInfoState ?? NoneTopScheduleState(),
        middleTransportInfoState =
            middleTransportInfoState ?? const MiddleTransportInfoState(),
        bottomScheduleListState =
            bottomScheduleListState ?? BottomScheduleListState();

  @override
  List<Object?> get props => [
        status,
        daySchedule,
        calendarState,
        topScheduleInfoState,
        middleTransportInfoState,
        bottomScheduleListState,
      ];

  HomeState copyWith({
    HomeStatus? status,
    DaySchedule? daySchedule,
    CalendarState? calendarState,
    SealedTopScheduleState? topScheduleInfoState,
    MiddleTransportInfoState? middleTransportInfoState,
    BottomScheduleListState? bottomScheduleListState,
  }) =>
      HomeState(
        status: status ?? this.status,
        daySchedule: daySchedule ?? this.daySchedule,
        calendarState: calendarState ?? this.calendarState,
        topScheduleInfoState: topScheduleInfoState ?? this.topScheduleInfoState,
        middleTransportInfoState:
            middleTransportInfoState ?? this.middleTransportInfoState,
        bottomScheduleListState:
            bottomScheduleListState ?? this.bottomScheduleListState,
      );
}
