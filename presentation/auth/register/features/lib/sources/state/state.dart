part of '../../eb_register_feature.dart';

final class RegisterState extends Equatable {
  final NickNameState nickNameState;
  final EmailState emailState;
  final PasswordState passwordState;
  final PasswordConfirmState passwordConfirmState;
  final RegisterStatus status;
  bool get inputIsValid => (nickNameState.nickName.isValid &&
      emailState.email.isValid &&
      passwordState.password.isValid &&
      passwordConfirmState.passwordConfirm.isValid);

  const RegisterState({
    this.nickNameState = const NickNameState(),
    this.emailState = const EmailState(),
    this.passwordState = const PasswordState(),
    this.passwordConfirmState = const PasswordConfirmState(),
    this.status = RegisterStatus.initial,
  });

  RegisterState copyWith({
    NickNameState? nickNameState,
    EmailState? emailState,
    PasswordState? passwordState,
    PasswordConfirmState? passwordConfirmState,
    RegisterStatus? status,
  }) {
    return RegisterState(
      nickNameState: nickNameState ?? this.nickNameState,
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      passwordConfirmState: passwordConfirmState ?? this.passwordConfirmState,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        nickNameState,
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
