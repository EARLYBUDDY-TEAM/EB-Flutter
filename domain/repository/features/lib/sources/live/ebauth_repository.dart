part of '../../eb_repository.dart';

final class EBAuthRepository {
  final NetworkService _networkService;

  EBAuthRepository({
    NetworkService? networkService,
  }) : _networkService = networkService ?? NetworkService.shared;

  Future<NetworkResponse<Token>> logIn({
    required String email,
    required String password,
  }) async {
    final fcmToken = await NotificationManager.getFCMToken() ?? '';
    final request = AuthRequest.login(
      email: email,
      password: password,
      fcmToken: fcmToken,
    );
    final result = await _networkService.request(request);
    switch (result) {
      case (SuccessResponse()):
        final Token token = Token.fromDTO(tokenDTO: result.model);
        return result.copyWith<Token>(model: token);
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result.copyWith<Token>();
    }
  }

  Future<NetworkResponse<EmptyDTO>> register({
    required String nickName,
    required String email,
    required String password,
  }) async {
    final request = AuthRequest.register(
      nickName: nickName,
      email: email,
      password: password,
    );

    final result = await _networkService.request(request);

    switch (result) {
      case (SuccessResponse()):
        return result;
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result;
    }
  }

  Future<NetworkResponse<EmptyDTO>> changePassword({
    required String email,
    required String password,
  }) async {
    final request = AuthRequest.changePassword(
      email: email,
      password: password,
    );

    final result = await _networkService.request(request);

    switch (result) {
      case (SuccessResponse()):
        return result;
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result;
    }
  }

  Future<NetworkResponse<EmptyDTO>> removeUser({
    required String accessToken,
  }) async {
    final request = AuthRequest.removeUser(accessToken: accessToken);
    final result = await _networkService.request(request);

    switch (result) {
      case (SuccessResponse()):
        return result;
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result;
    }
  }
}
