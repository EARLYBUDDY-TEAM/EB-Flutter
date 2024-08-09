part of 'bloc.dart';

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

final class PressRegisterAlertOkButton extends HomeEvent {
  const PressRegisterAlertOkButton();
}

final class DismissLoginSnackbar extends HomeEvent {
  const DismissLoginSnackbar();
}
