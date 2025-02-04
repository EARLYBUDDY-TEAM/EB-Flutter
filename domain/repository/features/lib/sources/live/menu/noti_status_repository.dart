part of '../../../eb_repository.dart';

final class NotiStatusRepository {
  final NetworkService _networkService;

  NotiStatusRepository({
    NetworkService? networkService,
  }) : _networkService = networkService ?? NetworkService.shared;

  Future<NetworkResponse<bool>> get({
    required String userEmail,
  }) async {
    final request = NotiStatusRequest.get(userEmail: userEmail);
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
    final request = NotiStatusRequest.enable(
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
    final request = NotiStatusRequest.disable(userEmail: userEmail);
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
