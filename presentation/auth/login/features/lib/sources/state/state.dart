part of '../../eb_login_feature.dart';

final class LoginState extends Equatable {
  final EmailState emailState;
  final PasswordState passwordState;
  final LoginStatus status;
  final BaseStatus tokenStatus;

  bool get inputIsValid =>
      (emailState.email.isValid && passwordState.password.isValid);

  const LoginState({
    this.emailState = const EmailState(),
    this.passwordState = const PasswordState(),
    this.status = LoginStatus.initial,
    this.tokenStatus = BaseStatus.init,
  });

  LoginState copyWith({
    EmailState? emailState,
    PasswordState? passwordState,
    LoginStatus? status,
    BaseStatus? tokenStatus,
  }) {
    return LoginState(
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      status: status ?? this.status,
      tokenStatus: tokenStatus ?? this.tokenStatus,
    );
  }

  @override
  List<Object?> get props => [
        emailState,
        passwordState,
        status,
        tokenStatus,
      ];
}

enum LoginStatus {
  initial,
  inProgress,
  onError,
}
