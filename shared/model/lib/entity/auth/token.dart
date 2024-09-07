part of '../../entity.dart';

final class Token extends Equatable {
  final String email;
  final String accessToken;
  final String refreshToken;

  const Token({
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  Token.fromDTO({
    required String email,
    required TokenDTO tokenDTO,
  })  : email = email,
        accessToken = tokenDTO.accessToken,
        refreshToken = tokenDTO.refreshToken;

  static Token mock() {
    return const Token(
      email: 'abc@abc.com',
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
    );
  }

  @override
  List<Object?> get props => [
        email,
        accessToken,
        refreshToken,
      ];
}
