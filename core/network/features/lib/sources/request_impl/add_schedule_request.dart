part of 'request_impl.dart';

final class AddScheduleRequest {
  static ApiRequest<EmptyDTO> init({
    required String accessToken,
    required Map<String, dynamic> scheduleInfo,
  }) {
    return ApiRequest(
      path: '/schedule/add',
      method: HTTPMethod.post,
      headers: {"access_token": accessToken},
      requestData: scheduleInfo,
    );
  }
}
