part of '../domain_model.dart';

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

final class Token extends Equatable {
  final String accessToken;
  final String tokenType;
  final String email;

  const Token({
    required this.accessToken,
    required this.tokenType,
    required this.email,
  });

  Token.fromDTO({required TokenDTO tokenDTO})
      : accessToken = tokenDTO.accessToken,
        tokenType = tokenDTO.tokenType,
        email = tokenDTO.email;

  static Token mock() {
    return const Token(
      accessToken: 'accessToken',
      tokenType: 'tokenType',
      email: 'email',
    );
  }

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
        email,
      ];
}
