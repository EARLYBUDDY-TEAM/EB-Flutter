part of '../../eb_login_feature.dart';

final class LoginState extends Equatable {
  final EmailState emailState;
  final PasswordState passwordState;
  final LoginStatus loginStatus;
  final BaseStatus tokenStatus;
  final bool isAutoLogin;
  final bool completeLogout;

  bool get inputIsValid =>
      (emailState.email.isValid && passwordState.password.isValid);

  const LoginState({
    this.emailState = const EmailState(),
    this.passwordState = const PasswordState(),
    this.loginStatus = LoginStatus.initial,
    this.tokenStatus = BaseStatus.init,
    this.isAutoLogin = false,
    this.completeLogout = false,
  });

  LoginState copyWith({
    EmailState? emailState,
    PasswordState? passwordState,
    LoginStatus? loginStatus,
    BaseStatus? tokenStatus,
    bool? isAutoLogin,
    bool? completeLogout,
  }) {
    return LoginState(
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      loginStatus: loginStatus ?? this.loginStatus,
      tokenStatus: tokenStatus ?? this.tokenStatus,
      isAutoLogin: isAutoLogin ?? this.isAutoLogin,
      completeLogout: completeLogout ?? this.completeLogout,
    );
  }

  @override
  List<Object?> get props => [
        emailState,
        passwordState,
        loginStatus,
        tokenStatus,
        isAutoLogin,
        completeLogout,
      ];
}

enum LoginStatus {
  initial,
  inProgress,
  onError,
}
