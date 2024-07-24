part of '../bloc.dart';

final class RegisterState extends Equatable {
  final EmailState emailState;
  final PasswordState passwordState;
  final PasswordConfirmState passwordConfirmState;
  final RegisterStatus status;
  bool get inputIsValid => (emailState.email.isValid &&
      passwordState.password.isValid &&
      passwordConfirmState.passwordConfirm.isValid);

  const RegisterState({
    this.emailState = const EmailState(),
    this.passwordState = const PasswordState(),
    this.passwordConfirmState = const PasswordConfirmState(),
    this.status = RegisterStatus.initial,
  });

  RegisterState copyWith({
    EmailState? emailState,
    PasswordState? passwordState,
    PasswordConfirmState? passwordConfirmState,
    RegisterStatus? status,
  }) {
    return RegisterState(
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      passwordConfirmState: passwordConfirmState ?? this.passwordConfirmState,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        emailState,
        passwordState,
        passwordConfirmState,
        inputIsValid,
        status,
      ];
}

enum RegisterStatus {
  initial,
  inProgress,
  onError,
}
