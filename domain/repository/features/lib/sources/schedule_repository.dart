part of '../eb_repository.dart';

final class ScheduleRepository {
  final NetworkService service;
  final SecureStorage _secureStorage;

  ScheduleRepository({
    NetworkService? networkService,
    SecureStorage? secureStorage,
  })  : service = networkService ?? NetworkService(),
        _secureStorage = secureStorage ?? SecureStorage();

  Future<Result> addSchedule({
    required ScheduleInfo scheduleInfo,
  }) async {
    final toUpload = scheduleInfo.toMap();
    final accessToken =
        await _secureStorage.read(key: SecureStorageKey.accessToken);

    final request = AddScheduleRequest.init(
      accessToken: accessToken,
      scheduleInfo: toUpload,
    );
    final result = await service.request(request);

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
}
