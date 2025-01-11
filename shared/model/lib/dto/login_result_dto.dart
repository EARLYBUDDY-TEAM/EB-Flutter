part of '../dto.dart';

final class LoginResultDTO {
  final String nickName;
  final TokenDTO tokenDTO;

  LoginResultDTO({
    required this.nickName,
    required this.tokenDTO,
  });

  static LoginResultDTO fromJson(Map<String, dynamic> j) {
    final nickName = j['nick_name'] as String;
    final tokenDTO = TokenDTO.fromJson(j['token_info']);
    return LoginResultDTO(
      nickName: nickName,
      tokenDTO: tokenDTO,
    );
  }
}
