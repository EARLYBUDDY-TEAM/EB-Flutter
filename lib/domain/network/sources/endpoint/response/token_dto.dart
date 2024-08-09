final class TokenDTO {
  final String accessToken;
  final String tokenType;
  final String email;

  TokenDTO({
    required this.accessToken,
    required this.tokenType,
    required this.email,
  });

  static TokenDTO fromJson(Map<String, dynamic> j) {
    return TokenDTO(
      accessToken: j['accessToken'],
      tokenType: j['tokenType'],
      email: j['email'],
    );
  }
}
