part of 'register_bloc.dart';

final class RegisterState extends Equatable {
  final RegisterEmailState emailState;
  final RegisterPasswordState passwordState;
  final RegisterPasswordConfirmState passwordConfirmState;
  final bool inputIsValid;

  const RegisterState({
    this.emailState = const RegisterEmailState(),
    this.passwordState = const RegisterPasswordState(),
    this.passwordConfirmState = const RegisterPasswordConfirmState(),
    this.inputIsValid = false,
  });

  RegisterState copyWith({
    RegisterEmailState? emailState,
    RegisterPasswordState? passwordState,
    RegisterPasswordConfirmState? passwordConfirmState,
    bool? inputIsValid,
  }) {
    return RegisterState(
      emailState: emailState ?? this.emailState,
      passwordState: passwordState ?? this.passwordState,
      passwordConfirmState: passwordConfirmState ?? this.passwordConfirmState,
      inputIsValid: inputIsValid ?? this.inputIsValid,
    );
  }

  @override
  List<Object?> get props =>
      [emailState, passwordState, passwordConfirmState, inputIsValid];
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
    this.isValidPassword = false,
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
  final Password password;
  final bool isValidPassword;

  const RegisterPasswordConfirmState({
    this.password = const Password.pure(),
    this.isValidPassword = false,
  });

  RegisterPasswordConfirmState copyWith({
    Password? password,
    bool? isValidPassword,
  }) {
    return RegisterPasswordConfirmState(
      password: password ?? this.password,
      isValidPassword: isValidPassword ?? this.isValidPassword,
    );
  }

  @override
  List<Object?> get props => [password, isValidPassword];
}
