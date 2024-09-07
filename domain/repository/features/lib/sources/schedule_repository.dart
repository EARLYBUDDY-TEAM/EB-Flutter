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
    log(toUpload.toString());
    final userEmail = await _secureStorage.read(key: 'email');

    final request = AddScheduleRequest.init(
      userEmail: userEmail,
      scheduleInfo: toUpload,
    );
    final result = await service.request(request);

    switch (result) {
      case (Success()):
        return result;
      case (Failure()):
        log(result.failure.error.toString());
        return result;
    }
  }
}
