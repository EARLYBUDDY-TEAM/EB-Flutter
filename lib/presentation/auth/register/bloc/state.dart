part of 'bloc.dart';

final class RegisterState extends Equatable {
  final Email email;
  final Password password;
  final PasswordConfirm passwordConfirm;
  final RegisterStatus status;
  bool get inputIsValid =>
      (email.isValid && password.isValid && passwordConfirm.isValid);

  const RegisterState({
    this.email = const Email(),
    this.password = const Password(),
    this.passwordConfirm = const PasswordConfirm(),
    this.status = RegisterStatus.initial,
  });

  RegisterState copyWith({
    Email? email,
    Password? password,
    PasswordConfirm? passwordConfirm,
    RegisterStatus? status,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        passwordConfirm,
        inputIsValid,
        status,
      ];
}

enum RegisterStatus {
  initial,
  inProgress,
  onError,
}

final class PasswordConfirm extends Equatable implements EBFormzAB {
  @override
  final String value;
  final String origin;
  @override
  bool get isValid => validator();

  const PasswordConfirm({
    this.value = '',
    this.origin = '',
  });

  PasswordConfirm copyWith({
    String? value,
    String? origin,
  }) {
    return PasswordConfirm(
      value: value ?? this.value,
      origin: origin ?? this.origin,
    );
  }

  @override
  bool validator() {
    return (value == origin);
  }

  @override
  List<Object?> get props => [value, origin];
}
