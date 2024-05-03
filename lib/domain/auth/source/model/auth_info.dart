import 'package:earlybuddy/core/network/endpoint/response/token_dto.dart';

enum AuthStatus { authenticated, unauthenticated }

final class AuthInfo {
  final AuthStatus status;
  final Token? token;

  const AuthInfo({
    required this.status,
    required this.token,
  });

  const AuthInfo.auth(Token token)
      : this(status: AuthStatus.authenticated, token: token);
  const AuthInfo.unAuth()
      : this(status: AuthStatus.unauthenticated, token: null);
}

final class Token {
  final String accessToken;
  final String tokenType;
  final String email;

  Token({
    required this.accessToken,
    required this.tokenType,
    required this.email,
  });

  Token.fromDTO({required TokenDTO tokenDTO})
      : accessToken = tokenDTO.accessToken,
        tokenType = tokenDTO.tokenType,
        email = tokenDTO.email;
}
