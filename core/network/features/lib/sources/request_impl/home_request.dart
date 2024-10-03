part of 'request_impl.dart';

final class HomeRequest {
  static ApiRequest<ScheduleCardListDTO> getAllScheduleCards({
    required String accessToken,
  }) {
    const path = "/home/get_all_schedule_cards";
    ScheduleCardListDTO converter(dynamic responseData) =>
        ScheduleCardListDTO.fromJson(responseData);

    return ApiRequest(
      path: path,
      method: HTTPMethod.get,
      headers: {"access_token": accessToken},
      converter: converter,
    );
  }
}
