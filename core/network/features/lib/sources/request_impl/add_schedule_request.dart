part of 'request_impl.dart';

final class AddScheduleRequest {
  static ApiRequest<EmptyDTO> init({
    required String userEmail,
    required Map<String, dynamic> scheduleInfo,
  }) {
    return ApiRequest(
      path: '/schedule/add',
      method: HTTPMethod.post,
      query: {"userEmail": userEmail},
      requestData: scheduleInfo,
    );
  }
}
