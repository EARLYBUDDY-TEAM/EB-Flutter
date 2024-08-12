part of '../entity.dart';

final class Token extends Equatable {
  final String accessToken;
  final String refreshToken;

  const Token({
    required this.accessToken,
    required this.refreshToken,
  });

  Token.fromDTO({required TokenDTO tokenDTO})
      : accessToken = tokenDTO.accessToken,
        refreshToken = tokenDTO.refreshToken;

  static Token mock() {
    return const Token(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
    );
  }

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
      ];
}
