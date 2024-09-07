part of '../eb_repository.dart';

final class EBAuthRepository {
  final controller = StreamController<AuthStatus>();
  final NetworkService _networkService;
  final SecureStorage _secureStorage;

  EBAuthRepository({
    NetworkService? networkService,
    SecureStorage? secureStorage,
  })  : _networkService = networkService ?? NetworkService(),
        _secureStorage = secureStorage ?? SecureStorage();

  Stream<AuthStatus> get authInfo async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield UnAuthenticated();
    yield* controller.stream;
  }

  void dispose() => controller.close();

  Future<Result> logIn({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest.init(email: email, password: password);
    final result = await _networkService.request(request);
    switch (result) {
      case (Success()):
        TokenDTO tokenDTO = result.success.model;
        final Token token = Token.fromDTO(
          email: email,
          tokenDTO: tokenDTO,
        );
        return Success(
          success: SuccessResponse(
            model: token,
            statusCode: result.success.statusCode,
          ),
        );
      case (Failure()):
        log(result.failure.error.toString());
        return result;
    }
  }

  Future<Result> register({
    required String email,
    required String password,
  }) async {
    final request = RegisterRequest.init(email: email, password: password);

    final result = await _networkService.request(request);
    switch (result) {
      case (Success()):
        return result;
      case (Failure()):
        log(result.failure.error.toString());
        return result;
    }
  }

  Future<void> saveToken(Token token) async {
    await _secureStorage.write(key: 'email', value: token.email);
    await _secureStorage.write(key: 'accessToken', value: token.accessToken);
    await _secureStorage.write(key: 'refreshToken', value: token.refreshToken);
  }

  Future<void> addAuthenticate(Token token) async {
    await saveToken(token);
    controller.add(Authenticated());
  }

  void logOut() {
    controller.add(UnAuthenticated());
  }
}
