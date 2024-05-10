part of 'auth_bloc.dart';

final class AuthState extends Equatable {
  final EBAuthStatus status;
  final EBToken? token;

  const AuthState({
    required this.status,
    required this.token,
  });

  const AuthState.auth(EBToken token)
      : this(status: EBAuthStatus.authenticated, token: token);
  const AuthState.unAuth()
      : this(status: EBAuthStatus.unauthenticated, token: null);

  @override
  List<Object?> get props => [status, token];
}
