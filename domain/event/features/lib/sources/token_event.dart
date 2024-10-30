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

  Future<Result> checkExpired({
    required Future<Result> Function(String accessToken) withEvent,
  }) async {
    String accessToken;
    try {
      accessToken =
          await _secureStorage.read(key: SecureStorageKey.accessToken);
    } catch (e) {
      return Failure(failure: e);
    }
    final Result firstResult = await withEvent(accessToken);
    switch (firstResult) {
      case Success():
        return firstResult;
      case Failure():
        final FailureResponse firstFailure = firstResult.failure;
        switch (firstFailure.statusCode) {
          case (490):
            final recreateTokenResult = await _tokenRepository.recreateToken();
            switch (recreateTokenResult) {
              case (Success()):
                final Token token = recreateTokenResult.success.model;
                final Result secondResult = await withEvent(token.accessToken);
                return secondResult;
              case (Failure()):
                _loginDelegate.tokenStatus.add(BaseStatus.fail);
                _rootDelegate.authStatus.add(UnAuthenticated());
                return recreateTokenResult;
            }
          default:
            return firstResult;
        }
    }
  }

  void failureAction({
    required Failure result,
    required Function() withAction,
  }) {
    if (result.failure.statusCode != 490) {
      withAction();
    }
  }
}
