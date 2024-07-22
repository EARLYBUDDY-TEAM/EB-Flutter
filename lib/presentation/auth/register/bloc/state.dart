part of 'bloc.dart';

final class RegisterState extends Equatable {
  final EmailState emailState;
  final PasswordState passwordState;
  final PasswordConfirmState passwordConfirmState;
  final bool inputIsValid;
  final FormzSubmissionStatus status;

  const RegisterState({
    this.emailState = const EmailState(),
    this.passwordState = const PasswordState(),
    this.passwordConfirmState = const PasswordConfirmState(),
    this.inputIsValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  RegisterState copyWith({
    EmailState? emailState,
    PasswordState? passwordState,
    PasswordConfirmState? passwordConfirmState,
    bool? inputIsValid,
    FormzSubmissionStatus? status,
  }) {
    return RegisterState(
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      passwordConfirmState: passwordConfirmState ?? this.passwordConfirmState,
      inputIsValid: inputIsValid ?? this.inputIsValid,
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

final class EmailState extends Equatable {
  final Email email;
  final bool isValidEmail;

  const EmailState({
    this.email = const Email.pure(),
    this.isValidEmail = true,
  });

  EmailState copyWith({
    Email? email,
    bool? isValidEmail,
  }) {
    return EmailState(
      email: email ?? this.email,
      isValidEmail: isValidEmail ?? this.isValidEmail,
    );
  }

  @override
  List<Object?> get props => [email, isValidEmail];
}

final class PasswordState extends Equatable {
  final Password password;
  final bool isValidPassword;

  const PasswordState({
    this.password = const Password.pure(),
    this.isValidPassword = true,
  });

  PasswordState copyWith({
    Password? password,
    bool? isValidPassword,
  }) {
    return PasswordState(
      password: password ?? this.password,
      isValidPassword: isValidPassword ?? this.isValidPassword,
    );
  }

  @override
  List<Object?> get props => [password, isValidPassword];
}

final class PasswordConfirmState extends Equatable {
  final Password passwordConfirm;
  final bool isValidPasswordConfirm;

  const PasswordConfirmState({
    this.passwordConfirm = const Password.pure(),
    this.isValidPasswordConfirm = true,
  });

  PasswordConfirmState copyWith({
    Password? passwordConfirm,
    bool? isValidPasswordConfirm,
  }) {
    return PasswordConfirmState(
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      isValidPasswordConfirm:
          isValidPasswordConfirm ?? this.isValidPasswordConfirm,
    );
  }

  @override
  List<Object?> get props => [passwordConfirm, isValidPasswordConfirm];
}
