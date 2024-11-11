part of 'request_impl.dart';

final class HomeRequest {
  static ApiRequest<SchedulePathListDTO> getAllSchedules({
    required String accessToken,
  }) {
    const path = "/home/get_all_schedules";
    SchedulePathListDTO converter(dynamic responseData) =>
        SchedulePathListDTO.fromJson(responseData);
    final header = {"access_token": accessToken};

    return ApiRequest(
      path: path,
      headers: header,
      converter: converter,
      method: HTTPMethod.get,
    );
  }

  static ApiRequest<RealTimeInfoDTOList> getBusRealTimeInfo(
      {required int stationID, get_bus_realtime_info}) {
    const path = "/realtime/get_bus_realtime_info";
    final query = {"station_id": "$stationID"};
    RealTimeInfoDTOList converter(dynamic responseData) =>
        RealTimeInfoDTOList.fromJson(responseData);

    return ApiRequest(
      path: path,
      query: query,
      converter: converter,
      method: HTTPMethod.get,
    );
  }
}
