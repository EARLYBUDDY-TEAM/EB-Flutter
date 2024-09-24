part of '../eb_event.dart';

final class TokenEvent {
  final RootDelegate _rootDelegate;
  final LoginDelegate _loginDelegate;

  final TokenRepository _tokenRepository;

  TokenEvent({
    required RootDelegate rootDelegate,
    required LoginDelegate loginDelegate,
    required TokenRepository tokenRepository,
  })  : _rootDelegate = rootDelegate,
        _loginDelegate = loginDelegate,
        _tokenRepository = tokenRepository;

  Future<Result> check({
    required Result preResult,
  }) async {
    switch (preResult) {
      case Success():
        return preResult;
      case Failure():
        switch (preResult.failure.statusCode) {
          case (490):
            final recreateTokenResult = await _tokenRepository.recreateToken();
            switch (recreateTokenResult) {
              case (Success()):
                return recreateTokenResult;
              case (Failure()):
                _loginDelegate.tokenStatus.add(BaseStatus.fail);
                _rootDelegate.authStatus.add(UnAuthenticated());
                return recreateTokenResult;
            }
          default:
            return preResult;
        }
    }
  }
}
