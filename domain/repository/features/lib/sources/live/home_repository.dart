part of '../../eb_repository.dart';

final class HomeRepository implements HomeRepositoryAB {
  final NetworkService service;

  HomeRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService.shared;

  @override
  Future<NetworkResponse<List<SchedulePath>>> getAllSchedules({
    required String accessToken,
  }) async {
    final request = HomeRequest.getAllSchedules(
      accessToken: accessToken,
    );
    final result = await service.request(request);

    switch (result) {
      case (SuccessResponse()):
        final List<SchedulePath> schedulePathList = result.model.allScheduleDTO
            .map((dto) => SchedulePath.fromDTO(dto: dto))
            .toList();
        return result.copyWith<List<SchedulePath>>(model: schedulePathList);
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result.copyWith<List<SchedulePath>>();
    }
  }

  @override
  Future<NetworkResponse<List<RealTimeInfo>>> getBusRealTimeInfo({
    required int stationID,
  }) async {
    final request = HomeRequest.getBusRealTimeInfo(stationID: stationID);
    final result = await service.request(request);

    final decoded = _decodeRealTimeInfo(result: result);
    return decoded;
  }

  @override
  Future<NetworkResponse<List<RealTimeInfo>>> getSubwayRealTimeInfo({
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
}

extension on HomeRepository {
  NetworkResponse<List<RealTimeInfo>> _decodeRealTimeInfo({
    required NetworkResponse<RealTimeInfoDTOList> result,
  }) {
    switch (result) {
      case SuccessResponse():
        final dtoList = result.model.realTimeInfoDTOList;
        final List<RealTimeInfo> realTimeInfoList = dtoList
            .map<RealTimeInfo>(
              (r) => RealTimeInfo.fromDTO(dto: r),
            )
            .toList();
        return result.copyWith<List<RealTimeInfo>>(model: realTimeInfoList);
      case FailureResponse():
        log(result.error.toString());
        log(result.statusCode.toString());
        return result.copyWith<List<RealTimeInfo>>();
    }
  }
}
