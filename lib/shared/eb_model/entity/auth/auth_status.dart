part of '../entity.dart';

sealed class AuthStatus extends Equatable {}

final class Authenticated extends AuthStatus {
  final Token token;

  Authenticated({
    required this.token,
  });

  static Authenticated mock() {
    return Authenticated(
      token: Token.mock(),
    );
  }

  @override
  List<Object?> get props => [token];
}

final class UnAuthenticated extends AuthStatus {
  @override
  List<Object?> get props => [];
}
