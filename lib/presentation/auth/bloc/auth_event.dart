part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthStatusChanged extends AuthEvent {
  final AuthInfo authInfo;

  const AuthStatusChanged(this.authInfo);
}

final class AuthLogoutRequested extends AuthEvent {}
