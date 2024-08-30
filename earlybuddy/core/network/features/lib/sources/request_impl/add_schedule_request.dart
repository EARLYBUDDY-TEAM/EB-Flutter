part of 'request_impl.dart';

final class AddScheduleRequest {
  static ApiRequest<EmptyDTO> init(Map<String, dynamic> scheduleInfo) {
    return ApiRequest(
      path: '/schedule/add',
      method: HTTPMethod.post,
      requestData: scheduleInfo,
    );
  }
}
