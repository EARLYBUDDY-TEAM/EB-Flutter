part of 'bloc.dart';

final class RegisterState extends Equatable {
  final RegisterEmailState emailState;
  final RegisterPasswordState passwordState;
  final RegisterPasswordConfirmState passwordConfirmState;
  final bool inputIsValid;
  final FormzSubmissionStatus status;

  const RegisterState({
    this.emailState = const RegisterEmailState(),
    this.passwordState = const RegisterPasswordState(),
    this.passwordConfirmState = const RegisterPasswordConfirmState(),
    this.inputIsValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  RegisterState copyWith({
    RegisterEmailState? emailState,
    RegisterPasswordState? passwordState,
    RegisterPasswordConfirmState? passwordConfirmState,
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
  List<Object?> get props =>
      [emailState, passwordState, passwordConfirmState, inputIsValid, status];
}

final class RegisterEmailState extends Equatable {
  final Email email;
  final bool isValidEmail;

  const RegisterEmailState({
    this.email = const Email.pure(),
    this.isValidEmail = true,
  });

  RegisterEmailState copyWith({
    Email? email,
    bool? isValidEmail,
  }) {
    return RegisterEmailState(
      email: email ?? this.email,
      isValidEmail: isValidEmail ?? this.isValidEmail,
    );
  }

  @override
  List<Object?> get props => [email, isValidEmail];
}

final class RegisterPasswordState extends Equatable {
  final Password password;
  final bool isValidPassword;

  const RegisterPasswordState({
    this.password = const Password.pure(),
    this.isValidPassword = true,
  });

  RegisterPasswordState copyWith({
    Password? password,
    bool? isValidPassword,
  }) {
    return RegisterPasswordState(
      password: password ?? this.password,
      isValidPassword: isValidPassword ?? this.isValidPassword,
    );
  }

  @override
  List<Object?> get props => [password, isValidPassword];
}

final class RegisterPasswordConfirmState extends Equatable {
  final Password passwordConfirm;
  final bool isValidPasswordConfirm;

  const RegisterPasswordConfirmState({
    this.passwordConfirm = const Password.pure(),
    this.isValidPasswordConfirm = true,
  });

  RegisterPasswordConfirmState copyWith({
    Password? passwordConfirm,
    bool? isValidPasswordConfirm,
  }) {
    return RegisterPasswordConfirmState(
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      isValidPasswordConfirm:
          isValidPasswordConfirm ?? this.isValidPasswordConfirm,
    );
  }

  @override
  List<Object?> get props => [passwordConfirm, isValidPasswordConfirm];
}
