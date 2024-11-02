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

  static ApiRequest<RealTimeInfoDTO> getBusRealTimeInfo({
    required int stationID,
  }) {
    const path = "/home/get_info_with_bus_station_id";
    final query = {"station_id": "$stationID"};
    RealTimeInfoDTO converter(dynamic responseData) =>
        RealTimeInfoDTO.fromJson(responseData);

    return ApiRequest(
      path: path,
      query: query,
      converter: converter,
      method: HTTPMethod.get,
    );
  }
}
