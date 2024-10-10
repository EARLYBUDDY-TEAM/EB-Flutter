part of '../eb_home_feature.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class OnAppearHomeView extends HomeEvent {
  const OnAppearHomeView();

  @override
  List<Object?> get props => [];
}

final class DeleteScheduleCard extends HomeEvent {
  final int scheduleID;

  const DeleteScheduleCard({required this.scheduleID});

  @override
  List<Object?> get props => [scheduleID];
}

final class SetHomeStatus extends HomeEvent {
  final BaseStatus? login;
  final BaseStatus? register;
  final BaseStatus? getAllScheduleCard;
  final BaseStatus? deleteScheduleCard;

  const SetHomeStatus({
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

final class TapCalendarDay extends HomeEvent {
  final DateTime selectedDay;

  const TapCalendarDay({
    required this.selectedDay,
  });

  @override
  List<Object?> get props => [];
}
