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
    final scheduleDTO = schedule.toDTO();
    final scheduleMap = scheduleDTO.toMap();
    final ebPathDTO = ebPath?.toDTO();
    final pathMap = ebPathDTO?.toMap();

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

  Future<Result> update({
    required String accessToken,
    required Schedule schedule,
    required EBPath? ebPath,
  }) async {
    final scheduleDTO = schedule.toDTO();
    final scheduleMap = scheduleDTO.toMap();
    final pathDTO = ebPath?.toDTO();
    final pathMap = pathDTO?.toMap();

    log(pathMap.toString());
    final request = AddScheduleRequest.update(
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

  Future<Result> delete({
    required String accessToken,
    required String scheduleID,
  }) async {
    final request = AddScheduleRequest.delete(
      accessToken: accessToken,
      scheduleID: scheduleID,
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
