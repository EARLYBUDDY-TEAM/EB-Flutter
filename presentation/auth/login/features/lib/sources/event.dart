part of '../eb_login_feature.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class ChangeEmail extends LoginEvent {
  const ChangeEmail(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class ChangePassword extends LoginEvent {
  const ChangePassword(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class PressLoginButton extends LoginEvent {
  const PressLoginButton();
}

final class PressAlertOkButton extends LoginEvent {
  const PressAlertOkButton();
}

final class SetTokenStatus extends LoginEvent {
  final BaseStatus status;

  const SetTokenStatus({required this.status});

  @override
  List<Object?> get props => [status];
}

final class PressAutoLoginButton extends LoginEvent {
  final bool isAutoLogin;

  const PressAutoLoginButton({
    required this.isAutoLogin,
  });

  @override
  List<Object?> get props => [
        isAutoLogin,
      ];
}

final class SetAutoLogin extends LoginEvent {
  const SetAutoLogin();

  @override
  List<Object?> get props => [];
}

final class CompleteLogout extends LoginEvent {
  final BaseStatus status;

  const CompleteLogout({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
