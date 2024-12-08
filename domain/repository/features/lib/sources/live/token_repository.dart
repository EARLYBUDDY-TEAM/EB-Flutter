part of '../../eb_repository.dart';

final class TokenRepository {
  final SecureStorage _secureStorage;
  final NetworkService _networkService;

  TokenRepository({
    SecureStorage? secureStorage,
    NetworkService? networkService,
  })  : _secureStorage = secureStorage ?? SecureStorage(),
        _networkService = networkService ?? NetworkService();

  Future<NetworkResponse<Token>> recreateToken() async {
    final refreshToken =
        await _secureStorage.read(key: SecureStorageKey.refreshToken);
    final request = TokenRequest.init(refreshToken: refreshToken);
    final result = await _networkService.request(request);

    switch (result) {
      case (SuccessResponse()):
        final Token token = Token.fromDTO(
          tokenDTO: result.model,
        );
        await saveToken(token);
        return result.copyWith<Token>(model: token);
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result.copyWith<Token>();
    }
  }

  Future<void> saveToken(Token token) async {
    await _secureStorage.write(
      key: SecureStorageKey.accessToken,
      value: token.accessToken,
    );
    await _secureStorage.write(
      key: SecureStorageKey.refreshToken,
      value: token.refreshToken,
    );
  }
}
