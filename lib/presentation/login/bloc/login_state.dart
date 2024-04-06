part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.emailState = const LoginEmailState(),
    this.passwordState = const LoginPasswordState(),
    this.inputIsValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final LoginEmailState emailState;
  final LoginPasswordState passwordState;
  final bool inputIsValid;
  final FormzSubmissionStatus status;

  LoginState copyWith({
    LoginEmailState? emailState,
    LoginPasswordState? passwordState,
    bool? inputIsValid,
    FormzSubmissionStatus? status,
  }) {
    return LoginState(
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      inputIsValid: inputIsValid ?? this.inputIsValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [emailState, passwordState, inputIsValid];
}

final class LoginEmailState extends Equatable {
  const LoginEmailState({
    this.email = const Email.pure(),
    this.isError = false,
  });

  final Email email;
  final bool isError;

  LoginEmailState copyWith({
    Email? email,
    bool? isError,
  }) {
    return LoginEmailState(
      email: email ?? this.email,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [email, isError];
}

final class LoginPasswordState extends Equatable {
  const LoginPasswordState({
    this.password = const Password.pure(),
    this.isError = false,
  });

  final Password password;
  final bool isError;

  LoginPasswordState copyWith({
    Password? password,
    bool? isError,
  }) {
    return LoginPasswordState(
      password: password ?? this.password,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [password, isError];
}
