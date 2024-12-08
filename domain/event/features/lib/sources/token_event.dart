part of '../eb_event.dart';

final class TokenEvent {
  final RootDelegate _rootDelegate;
  final LoginDelegate _loginDelegate;
  final TokenRepository _tokenRepository;
  final SecureStorage _secureStorage;

  TokenEvent({
    required RootDelegate rootDelegate,
    required LoginDelegate loginDelegate,
    required TokenRepository tokenRepository,
    SecureStorage? secureStorage, // required
  })  : _rootDelegate = rootDelegate,
        _loginDelegate = loginDelegate,
        _tokenRepository = tokenRepository,
        _secureStorage = secureStorage ?? SecureStorage();

  Future<NetworkResponse<M>> checkExpired<M>({
    required Future<NetworkResponse<M>> Function(String accessToken) withEvent,
  }) async {
    String accessToken;
    try {
      accessToken =
          await _secureStorage.read(key: SecureStorageKey.accessToken);
    } catch (e) {
      return FailureResponse(
        statusCode: 444,
        error: NetworkError.secureStorageError,
      );
    }
    final NetworkResponse<M> firstResult = await withEvent(accessToken);
    switch (firstResult) {
      case SuccessResponse():
        return firstResult;
      case FailureResponse():
        switch (firstResult.statusCode) {
          case (490):
            final recreateTokenResult = await _tokenRepository.recreateToken();
            switch (recreateTokenResult) {
              case SuccessResponse():
                final Token token = recreateTokenResult.model;
                final NetworkResponse<M> secondResult =
                    await withEvent(token.accessToken);
                return secondResult;
              case (FailureResponse()):
                _loginDelegate.tokenStatus.add(BaseStatus.fail);
                _rootDelegate.authStatus.add(UnAuthenticated());
                return recreateTokenResult.copyWith<M>();
            }
          default:
            return firstResult;
        }
    }
  }

  void failureAction({
    required FailureResponse result,
    required Function() withAction,
  }) {
    if (result.statusCode != 490) {
      withAction();
    }
  }
}
