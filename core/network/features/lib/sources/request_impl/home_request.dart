part of 'request_impl.dart';

final class HomeRequest {
  static ApiRequest<ScheduleListDTO> getAllSchedules({
    required String accessToken,
  }) {
    const path = "/home/get_all_schedules";
    ScheduleListDTO converter(dynamic responseData) =>
        ScheduleListDTO.fromJson(responseData);
    final header = {"access_token": accessToken};

    return ApiRequest(
      path: path,
      headers: header,
      converter: converter,
      method: HTTPMethod.get,
    );
  }

  static ApiRequest<EmptyDTO> deleteScheduleCard({
    required String accessToken,
    required int scheduleID,
  }) {
    const path = '/home/delete_schedule';
    final Map<String, String> query = {"scheduleID": scheduleID.toString()};
    final header = {"access_token": accessToken};

    return ApiRequest(
      path: path,
      query: query,
      headers: header,
      method: HTTPMethod.delete,
    );
  }
}
