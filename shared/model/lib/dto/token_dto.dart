part of '../dto.dart';

final class TokenDTO {
  final String accessToken;
  final String refreshToken;

  TokenDTO({
    required this.accessToken,
    required this.refreshToken,
  });

  static TokenDTO fromJson(Map<String, dynamic> j) {
    return TokenDTO(
      accessToken: j['accessToken'],
      refreshToken: j['refreshToken'],
    );
  }
}
