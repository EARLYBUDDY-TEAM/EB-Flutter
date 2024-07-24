part of 'bloc.dart';

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
