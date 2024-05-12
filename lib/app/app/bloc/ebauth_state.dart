part of 'ebauth_bloc.dart';

final class EBAuthState extends Equatable {
  final EBAuthStatus status;
  final EBToken? token;

  const EBAuthState({
    required this.status,
    required this.token,
  });

  const EBAuthState.auth(EBToken token)
      : this(status: EBAuthStatus.authenticated, token: token);
  const EBAuthState.unAuth()
      : this(status: EBAuthStatus.unauthenticated, token: null);

  @override
  List<Object?> get props => [status, token];
}
