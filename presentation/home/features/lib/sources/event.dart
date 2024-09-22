part of '../eb_home_feature.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class PressAddScheduleButton extends HomeEvent {
  const PressAddScheduleButton();
}

final class PressMenuButton extends HomeEvent {
  const PressMenuButton();
}

final class SetLoginStatus extends HomeEvent {
  final BaseStatus status;

  const SetLoginStatus({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}

final class SetRegisterStatus extends HomeEvent {
  final BaseStatus status;

  const SetRegisterStatus({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
