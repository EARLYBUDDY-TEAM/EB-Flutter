part of 'request_impl.dart';

final class HomeRequest {
  static ApiRequest<ScheduleCardListDTO> getAllScheduleCards({
    required String accessToken,
  }) {
    const path = "/home/get_all_schedule_cards";
    ScheduleCardListDTO converter(dynamic responseData) =>
        ScheduleCardListDTO.fromJson(responseData);
    final header = {"access_token": accessToken};

    return ApiRequest(
      path: path,
      method: HTTPMethod.get,
      headers: header,
      converter: converter,
    );
  }

  static ApiRequest<EmptyDTO> deleteScheduleCard({
    required String accessToken,
    required int scheduleID,
  }) {
    const path = '/home/delete_schedule_card';
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
