part of '../../eb_repository.dart';

final class ScheduleRepository {
  final NetworkService _networkService;

  ScheduleRepository({
    NetworkService? networkService,
  }) : _networkService = networkService ?? NetworkService.shared;

  Future<NetworkResponse<EmptyDTO>> create({
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
    final result = await _networkService.request(request);

    switch (result) {
      case (SuccessResponse()):
        return result;
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result.copyWith<EmptyDTO>();
    }
  }

  Future<NetworkResponse<EmptyDTO>> update({
    required String accessToken,
    required Schedule schedule,
    required EBPath? ebPath,
  }) async {
    final scheduleDTO = schedule.toDTO();
    final scheduleMap = scheduleDTO.toMap();
    final pathDTO = ebPath?.toDTO();
    final pathMap = pathDTO?.toMap();

    final request = AddScheduleRequest.update(
      accessToken: accessToken,
      scheduleMap: scheduleMap,
      pathMap: pathMap,
    );
    final result = await _networkService.request(request);

    switch (result) {
      case (SuccessResponse()):
        return result;
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result.copyWith<EmptyDTO>();
    }
  }

  Future<NetworkResponse<EmptyDTO>> delete({
    required String accessToken,
    required String scheduleID,
  }) async {
    final request = AddScheduleRequest.delete(
      accessToken: accessToken,
      scheduleID: scheduleID,
    );

    final result = await _networkService.request(request);

    switch (result) {
      case (SuccessResponse()):
        return result;
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result.copyWith<EmptyDTO>();
    }
  }
}
