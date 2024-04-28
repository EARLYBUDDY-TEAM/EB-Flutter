part of 'auth_bloc.dart';

final class AuthState extends Equatable {
  final AuthStatus status;
  final Token? token;

  const AuthState({
    required this.status,
    required this.token,
  });

  const AuthState.auth(Token token)
      : this(status: AuthStatus.authenticated, token: token);
  const AuthState.unAuth()
      : this(status: AuthStatus.unauthenticated, token: null);

  @override
  List<Object?> get props => [status, token];
}
