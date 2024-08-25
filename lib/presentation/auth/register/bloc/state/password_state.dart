part of '../bloc.dart';

final class PasswordState extends Equatable {
  final Password password;
  final PasswordFormStatus status;

  const PasswordState({
    this.password = const Password(),
    this.status = PasswordFormStatus.initial,
  });

  PasswordState copyWith({
    Password? password,
    PasswordFormStatus? status,
  }) {
    return PasswordState(
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [password, status];
}

enum PasswordFormStatus {
  initial,
  typing,
  onError,
}
