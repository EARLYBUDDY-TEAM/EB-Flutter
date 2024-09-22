part of '../eb_repository.dart';

final class TokenRepository {
  final SecureStorage _secureStorage;
  final NetworkService _networkService;

  TokenRepository({
    SecureStorage? secureStorage,
    NetworkService? networkService,
  })  : _secureStorage = secureStorage ?? SecureStorage(),
        _networkService = networkService ?? NetworkService();

  Future<Result> withCheckToken(
    Future<Result> Function() operation,
  ) async {
    final Result operationResult = await operation();
    switch (operationResult) {
      case Success():
        return operationResult;
      case Failure():
        switch (operationResult.failure.statusCode) {
          case (490):
            final recreateTokenResult = await recreateToken();
            switch (recreateTokenResult) {
              case (Success()):
                TokenDTO tokenDTO = recreateTokenResult.success.model;
                final Token token = Token.fromDTO(
                  tokenDTO: tokenDTO,
                );
                await saveToken(token);
                return Success(
                  success: SuccessResponse(
                    model: token,
                    statusCode: recreateTokenResult.success.statusCode,
                  ),
                );
              case (Failure()):
                log(recreateTokenResult.failure.error.toString());
                return recreateTokenResult;
            }
          default:
            return operationResult;
        }
    }
  }

  Future<Result> recreateToken() async {
    final refreshToken =
        await _secureStorage.read(key: SecureStorageKey.refreshToken);
    final request = TokenRequest.init(refreshToken: refreshToken);
    final Result result = await _networkService.request(request);
    return result;
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
