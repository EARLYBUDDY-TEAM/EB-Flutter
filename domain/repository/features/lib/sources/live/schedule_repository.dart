part of '../../eb_repository.dart';

final class ScheduleRepository {
  final NetworkService service;

  ScheduleRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService();

  Future<Result> create({
    required String accessToken,
    required Schedule schedule,
    required EBPath? ebPath,
  }) async {
    final scheduleMap = schedule.toMap();
    final pathMap = ebPath?.toMap();
    final request = AddScheduleRequest.create(
      accessToken: accessToken,
      scheduleMap: scheduleMap,
      pathMap: pathMap,
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
