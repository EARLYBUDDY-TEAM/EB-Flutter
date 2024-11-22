part of '../../eb_repository.dart';

final class HomeRepository implements HomeRepositoryAB {
  final NetworkService service;

  HomeRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService();

  @override
  Future<Result> getAllSchedules({
    required String accessToken,
  }) async {
    final request = HomeRequest.getAllSchedules(
      accessToken: accessToken,
    );
    final result = await service.request(request);

    switch (result) {
      case (Success()):
        final SuccessResponse successResponse = result.success;
        final SchedulePathListDTO schedulePathListDTO = successResponse.model;
        final List<SchedulePath> schedulePathList = schedulePathListDTO
            .allScheduleDTO
            .map((dto) => SchedulePath.fromDTO(dto: dto))
            .toList();
        final newSuccessResponse = SuccessResponse(
          statusCode: successResponse.statusCode,
          model: schedulePathList,
        );
        final newResult = Success(success: newSuccessResponse);
        return newResult;
      case (Failure()):
        final FailureResponse failureResponse = result.failure;
        log(failureResponse.error.toString());
        log(failureResponse.statusCode.toString());
        return result;
    }
  }

  @override
  Future<Result> getBusRealTimeInfo({
    required int stationID,
  }) async {
    final request = HomeRequest.getBusRealTimeInfo(stationID: stationID);
    final result = await service.request(request);

    final decoded = _decodeRealTimeInfo(result: result);
    return decoded;
  }

  @override
  Future<Result> getSubwayRealTimeInfo({
    required String stationName,
    required String lineName,
    required int direction,
  }) async {
    final request = HomeRequest.getSubwayRealTimeInfo(
      stationName: stationName,
      lineName: lineName,
      direction: direction,
    );
    final result = await service.request(request);

    final decoded = _decodeRealTimeInfo(result: result);
    return decoded;
  }

  @override
  Future<Result> getTotalSubwaySchedule({
    required int stationID,
    required int wayCode,
  }) async {
    final request = HomeRequest.getTotalSubwaySchedule(
      stationID: stationID,
      wayCode: wayCode,
    );

    final result = await service.request(request);

    switch (result) {
      case Success():
        final SuccessResponse successResponse = result.success;
        final TotalSubwayScheduleDTO totalSubwayScheduleDTO =
            successResponse.model;
        final TotalSubwaySchedule totalSubwaySchedule =
            TotalSubwaySchedule.fromDTO(
          dto: totalSubwayScheduleDTO,
        );

        final newSuccessResponse = SuccessResponse(
          statusCode: successResponse.statusCode,
          model: totalSubwaySchedule,
        );
        final newResult = Success(success: newSuccessResponse);
        return newResult;
      case Failure():
        final FailureResponse failureResponse = result.failure;
        log(failureResponse.error.toString());
        log(failureResponse.statusCode.toString());
        return result;
    }
  }
}

extension on HomeRepository {
  Result _decodeRealTimeInfo({
    required Result result,
  }) {
    switch (result) {
      case Success():
        final SuccessResponse successResponse = result.success;
        final RealTimeInfoDTOList realTimeInfoDTOList = successResponse.model;
        final dtoList = realTimeInfoDTOList.realTimeInfoDTOList;
        final List<RealTimeInfo> realTimeInfoList = dtoList
            .map<RealTimeInfo>(
              (r) => RealTimeInfo.fromDTO(dto: r),
            )
            .toList();

        final newSuccessResponse = SuccessResponse(
          statusCode: successResponse.statusCode,
          model: realTimeInfoList,
        );
        final newResult = Success(success: newSuccessResponse);
        return newResult;
      case Failure():
        final FailureResponse failureResponse = result.failure;
        log(failureResponse.error.toString());
        log(failureResponse.statusCode.toString());
        return result;
    }
  }
}
