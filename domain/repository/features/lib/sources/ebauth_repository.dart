part of '../eb_repository.dart';

final class EBAuthRepository {
  // final RootDelegate _rootDelegate;
  final NetworkService _networkService;
  // final SecureStorage _secureStorage;

  EBAuthRepository({
    NetworkService? networkService,
    // SecureStorage? secureStorage,
    // RootDelegate? rootDelegate,
  }) : _networkService = networkService ?? NetworkService();
  // _secureStorage = secureStorage ?? SecureStorage();

  // Stream<AuthStatus> get authInfo async* {
  //   await Future<void>.delayed(const Duration(seconds: 1));
  //   yield UnAuthenticated();
  //   yield* controller.stream;
  // }

  // void dispose() => controller.close();

  Future<Result> logIn({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest.init(email: email, password: password);
    final result = await _networkService.request(request);
    switch (result) {
      case (Success()):
        TokenDTO tokenDTO = result.success.model;
        final Token token = Token.fromDTO(tokenDTO: tokenDTO);
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
        final FailureResponse failureResponse = result.failure;
        log(failureResponse.error.toString());
        log(failureResponse.statusCode.toString());
        return result;
    }
  }

  // Future<void> addAuthenticate(Token token) async {
  //   await saveToken(token);
  //   controller.add(Authenticated());
  // }

  // void logOut() {
  //   controller.add(UnAuthenticated());
  // }

  // Future<Result> withCheckToken(
  //   Result operationResult,
  // ) async {
  //   switch (operationResult) {
  //     case Success():
  //       return operationResult;
  //     case Failure():
  //       switch (operationResult.failure.statusCode) {
  //         case (490):
  //           final recreateTokenResult = await recreateToken();
  //           switch (recreateTokenResult) {
  //             case (Success()):
  //               TokenDTO tokenDTO = recreateTokenResult.success.model;
  //               final Token token = Token.fromDTO(
  //                 tokenDTO: tokenDTO,
  //               );
  //               await saveToken(token);
  //               return Success(
  //                 success: SuccessResponse(
  //                   model: token,
  //                   statusCode: recreateTokenResult.success.statusCode,
  //                 ),
  //               );
  //             case (Failure()):
  //               log(recreateTokenResult.failure.error.toString());
  //               // _rootDelegate.authStatus.add(UnAuthenticated());
  //               return recreateTokenResult;
  //           }
  //         default:
  //           return operationResult;
  //       }
  //   }
  // }

  // Future<Result> recreateToken() async {
  //   final refreshToken =
  //       await _secureStorage.read(key: SecureStorageKey.refreshToken);
  //   final request = TokenRequest.init(refreshToken: refreshToken);
  //   final Result result = await _networkService.request(request);
  //   return result;
  // }

  // Future<void> saveToken(Token token) async {
  //   await _secureStorage.write(
  //     key: SecureStorageKey.accessToken,
  //     value: token.accessToken,
  //   );
  //   await _secureStorage.write(
  //     key: SecureStorageKey.refreshToken,
  //     value: token.refreshToken,
  //   );
  // }
}
