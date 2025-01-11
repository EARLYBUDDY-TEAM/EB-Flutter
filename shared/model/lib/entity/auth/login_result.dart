part of '../../entity.dart';

final class LoginResult extends Equatable {
  final String nickName;
  final Token token;

  const LoginResult({
    required this.nickName,
    required this.token,
  });

  LoginResult.fromDTO({
    required LoginResultDTO dto,
  })  : nickName = dto.nickName,
        token = Token.fromDTO(tokenDTO: dto.tokenDTO);

  @override
  List<Object?> get props => [
        nickName,
        token,
      ];
}
