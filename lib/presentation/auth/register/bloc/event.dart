part of 'bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

final class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

final class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

final class RegisterPasswordConfirmChanged extends RegisterEvent {
  final String passwordConfirm;

  const RegisterPasswordConfirmChanged(this.passwordConfirm);

  @override
  List<Object?> get props => [passwordConfirm];
}

final class RegisterPressed extends RegisterEvent {
  const RegisterPressed();
}
