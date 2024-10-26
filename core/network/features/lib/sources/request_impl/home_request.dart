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

  static ApiRequest<EmptyDTO> deleteScheduleCard({
    required String accessToken,
    required String scheduleID,
  }) {
    const path = '/home/delete_schedule';
    final Map<String, String> query = {"scheduleID": scheduleID};
    final header = {"access_token": accessToken};

    return ApiRequest(
      path: path,
      query: query,
      headers: header,
      method: HTTPMethod.delete,
    );
  }
}
