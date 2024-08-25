part of '../bloc.dart';

final class PasswordConfirmState extends Equatable {
  final PasswordConfirm passwordConfirm;
  final PasswordConfirmFormStatus status;

  const PasswordConfirmState({
    this.passwordConfirm = const PasswordConfirm(),
    this.status = PasswordConfirmFormStatus.initial,
  });

  PasswordConfirmState copyWith({
    PasswordConfirm? passwordConfirm,
    PasswordConfirmFormStatus? status,
  }) {
    return PasswordConfirmState(
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [passwordConfirm, status];
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

enum PasswordConfirmFormStatus {
  initial,
  typing,
  onError,
}
