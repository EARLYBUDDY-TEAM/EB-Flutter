part of '../eb_repository.dart';

final class ScheduleRepository {
  final NetworkService service;

  ScheduleRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService.shared;

  Future<Result> addSchedule({
    required ScheduleInfo scheduleInfo,
  }) async {
    final request = AddScheduleRequest.init(scheduleInfo.toMap());
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
