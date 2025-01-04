part of '../../eb_repository.dart';

final class FCMTokenRepository {
  final NetworkService _networkService;

  FCMTokenRepository({
    NetworkService? networkService,
  }) : _networkService = networkService ?? NetworkService.shared;

  Future<NetworkResponse<bool>> isAuthorized({
    required String userEmail,
  }) async {
    final request = FCMTokenRequest.isAuthorized(userEmail: userEmail);
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

  Future<NetworkResponse<EmptyDTO>> enable({
    required String userEmail,
    required String fcmToken,
  }) async {
    final request = FCMTokenRequest.enable(
      userEmail: userEmail,
      fcmToken: fcmToken,
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

  Future<NetworkResponse<EmptyDTO>> disable({
    required String userEmail,
  }) async {
    final request = FCMTokenRequest.disable(userEmail: userEmail);
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
