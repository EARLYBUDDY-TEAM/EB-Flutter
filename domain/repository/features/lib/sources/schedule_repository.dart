part of '../eb_repository.dart';

final class ScheduleRepository {
  final NetworkService service;

  ScheduleRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService();

  Future<Result> addSchedule({
    required String accessToken,
    required ScheduleInfo scheduleInfo,
  }) async {
    final uploadScheduleInfo = scheduleInfo.toMap();
    final request = AddScheduleRequest.init(
      accessToken: accessToken,
      scheduleInfo: uploadScheduleInfo,
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
