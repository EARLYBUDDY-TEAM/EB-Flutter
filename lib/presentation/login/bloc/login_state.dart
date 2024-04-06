part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.emailState = const EmailState(),
    this.passwordState = const PasswordState(),
    this.inputIsValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final EmailState emailState;
  final PasswordState passwordState;
  final bool inputIsValid;
  final FormzSubmissionStatus status;

  LoginState copyWith({
    EmailState? emailState,
    PasswordState? passwordState,
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

final class EmailState extends Equatable {
  const EmailState({
    this.email = const Email.pure(),
    this.isError = false,
  });

  final Email email;
  final bool isError;

  EmailState copyWith({
    Email? email,
    bool? isError,
  }) {
    return EmailState(
      email: email ?? this.email,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [email, isError];
}

final class PasswordState extends Equatable {
  const PasswordState({
    this.password = const Password.pure(),
    this.isError = false,
  });

  final Password password;
  final bool isError;

  PasswordState copyWith({
    Password? password,
    bool? isError,
  }) {
    return PasswordState(
      password: password ?? this.password,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [password, isError];
}
