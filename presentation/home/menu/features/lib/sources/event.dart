part of '../eb_menu_feature.dart';

sealed class MenuEvent extends Equatable {}

final class PressLogoutButton extends MenuEvent {
  @override
  List<Object?> get props => [];
}

final class ChangePassword extends MenuEvent {
  final String password;

  ChangePassword({
    required this.password,
  });

  @override
  List<Object?> get props => [password];
}

final class ChangePasswordConfirm extends MenuEvent {
  final String passwordConfirm;

  ChangePasswordConfirm({
    required this.passwordConfirm,
  });

  @override
  List<Object?> get props => [passwordConfirm];
}

final class PressChangePasswordButton extends MenuEvent {
  PressChangePasswordButton();

  @override
  List<Object?> get props => [];
}

final class SetMenuViewStatus extends MenuEvent {
  final BaseStatus? changePasswordStatus;
  final BaseStatus? removeUserStatus;

  SetMenuViewStatus({
    this.changePasswordStatus,
    this.removeUserStatus,
  });

  @override
  List<Object?> get props => [
        changePasswordStatus,
        removeUserStatus,
      ];
}

final class PressRemoveUserButton extends MenuEvent {
  PressRemoveUserButton();

  @override
  List<Object?> get props => [];
}

final class SetUnAuthenticated extends MenuEvent {
  SetUnAuthenticated();

  @override
  List<Object?> get props => [];
}

final class ToggleNotificationSwitch extends MenuEvent {
  ToggleNotificationSwitch();

  @override
  List<Object?> get props => [];
}

final class SetupHomeMenuListView extends MenuEvent {
  SetupHomeMenuListView();

  @override
  List<Object?> get props => [];
}
