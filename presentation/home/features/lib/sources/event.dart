part of '../eb_home_feature.dart';

sealed class HomeEvent extends Equatable {}

final class OnAppearHomeView extends HomeEvent {
  OnAppearHomeView();

  @override
  List<Object?> get props => [];
}

final class DeleteScheduleCard extends HomeEvent {
  final SchedulePath schedulePath;

  DeleteScheduleCard({required this.schedulePath});

  @override
  List<Object?> get props => [schedulePath];
}

final class SetHomeStatus extends HomeEvent {
  final BaseStatus? login;
  final BaseStatus? register;
  final BaseStatus? getAllScheduleCard;
  final BaseStatus? deleteScheduleCard;

  SetHomeStatus({
    this.login,
    this.register,
    this.getAllScheduleCard,
    this.deleteScheduleCard,
  });

  @override
  List<Object?> get props => [
        login,
        register,
        getAllScheduleCard,
        deleteScheduleCard,
      ];
}

final class SetCalendarState extends HomeEvent {
  final CalendarState calendarState;

  SetCalendarState({
    required this.calendarState,
  });

  @override
  List<Object?> get props => [calendarState];
}

final class PressReloadButton extends HomeEvent {
  @override
  List<Object?> get props => [];
}

final class SelectTransport extends HomeEvent {
  final Transport selectedTransport;

  SelectTransport({
    required this.selectedTransport,
  });

  @override
  List<Object?> get props => [selectedTransport];
}
