part of '../eb_repository.dart';

final class TokenRepository {
  final SecureStorage _secureStorage;
  final NetworkService _networkService;

  TokenRepository({
    SecureStorage? secureStorage,
    NetworkService? networkService,
  })  : _secureStorage = secureStorage ?? SecureStorage(),
        _networkService = networkService ?? NetworkService();

  Future<Result> recreateToken() async {
    final refreshToken =
        await _secureStorage.read(key: SecureStorageKey.refreshToken);
    final request = TokenRequest.init(refreshToken: refreshToken);
    final Result result = await _networkService.request(request);

    switch (result) {
      case (Success()):
        TokenDTO tokenDTO = result.success.model;
        final Token token = Token.fromDTO(
          tokenDTO: tokenDTO,
        );
        await saveToken(token);
        return Success(
          success: SuccessResponse(
            model: token,
            statusCode: result.success.statusCode,
          ),
        );
      case (Failure()):
        final FailureResponse failureResponse = result.failure;
        log(failureResponse.error.toString());
        log(failureResponse.statusCode.toString());
        return result;
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
