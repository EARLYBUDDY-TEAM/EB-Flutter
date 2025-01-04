part of '../eb_event.dart';

final class EBTokenEvent {
  final RootDelegate _rootDelegate;
  final LoginDelegate _loginDelegate;
  final EBTokenRepository _ebTokenRepository;
  final SecureStorage _secureStorage;

  EBTokenEvent({
    required RootDelegate rootDelegate,
    required LoginDelegate loginDelegate,
    required EBTokenRepository ebTokenRepository,
    SecureStorage? secureStorage,
  })  : _rootDelegate = rootDelegate,
        _loginDelegate = loginDelegate,
        _ebTokenRepository = ebTokenRepository,
        _secureStorage = secureStorage ?? SecureStorage.shared;

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
            final recreateTokenResult =
                await _ebTokenRepository.recreateToken();
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
