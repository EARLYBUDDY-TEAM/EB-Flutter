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

final class SetChangePasswordStatus extends MenuEvent {
  final BaseStatus status;

  SetChangePasswordStatus({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
