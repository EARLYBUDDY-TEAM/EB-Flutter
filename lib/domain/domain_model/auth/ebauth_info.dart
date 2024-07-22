part of '../domain_model.dart';

final class EBAuthInfo {
  final EBAuthStatus status;
  final EBToken? token;

  const EBAuthInfo({
    required this.status,
    required this.token,
  });

  const EBAuthInfo.auth(EBToken token)
      : this(status: EBAuthStatus.authenticated, token: token);
  const EBAuthInfo.unAuth()
      : this(status: EBAuthStatus.unauthenticated, token: null);
}

enum EBAuthStatus { authenticated, unauthenticated }

final class EBToken {
  final String accessToken;
  final String tokenType;
  final String email;

  EBToken({
    required this.accessToken,
    required this.tokenType,
    required this.email,
  });

  EBToken.fromDTO({required TokenDTO tokenDTO})
      : accessToken = tokenDTO.accessToken,
        tokenType = tokenDTO.tokenType,
        email = tokenDTO.email;
}
