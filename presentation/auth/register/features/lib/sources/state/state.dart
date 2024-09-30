part of '../../eb_register_feature.dart';

final class RegisterState extends Equatable {
  final NameState nameState;
  final EmailState emailState;
  final PasswordState passwordState;
  final PasswordConfirmState passwordConfirmState;
  final RegisterStatus status;
  bool get inputIsValid => (emailState.email.isValid &&
      passwordState.password.isValid &&
      passwordConfirmState.passwordConfirm.isValid);

  const RegisterState({
    this.nameState = const NameState(),
    this.emailState = const EmailState(),
    this.passwordState = const PasswordState(),
    this.passwordConfirmState = const PasswordConfirmState(),
    this.status = RegisterStatus.initial,
  });

  RegisterState copyWith({
    NameState? nameState,
    EmailState? emailState,
    PasswordState? passwordState,
    PasswordConfirmState? passwordConfirmState,
    RegisterStatus? status,
  }) {
    return RegisterState(
      nameState: nameState ?? this.nameState,
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      passwordConfirmState: passwordConfirmState ?? this.passwordConfirmState,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        nameState,
        emailState,
        passwordState,
        passwordConfirmState,
        status,
      ];
}

enum RegisterStatus {
  initial,
  inProgress,

  onErrorNotCorrectUser,
  onErrorExsitUser,
  onErrorLogin,
  onErrorUnknown,
}
