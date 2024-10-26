part of 'request_impl.dart';

final class AddScheduleRequest {
  static ApiRequest<EmptyDTO> create({
    required String accessToken,
    required Map<String, dynamic> scheduleMap,
    required Map<String, dynamic>? pathMap,
  }) {
    return ApiRequest(
      path: '/schedule/create',
      method: HTTPMethod.post,
      headers: {"access_token": accessToken},
      requestData: {
        "scheduleInfo": scheduleMap,
        "pathInfo": pathMap,
      },
    );
  }
}
