part of 'bloc.dart';

final class RootState extends Equatable {
  final EBAuthStatus status;
  final EBToken? token;

  const RootState({
    required this.status,
    required this.token,
  });

  const RootState.auth(EBToken token)
      : this(status: EBAuthStatus.authenticated, token: token);
  const RootState.unAuth()
      : this(status: EBAuthStatus.unauthenticated, token: null);

  @override
  List<Object?> get props => [status, token];
}
