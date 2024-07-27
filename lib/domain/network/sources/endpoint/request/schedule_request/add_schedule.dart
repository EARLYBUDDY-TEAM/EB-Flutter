part of '../request.dart';

final class AddScheduleRequest {
  static ApiRequest<EmptyDTO> init() {
    return ApiRequest(
      path: '/schedule/add',
      method: HTTPMethod.post,
    );
  }
}
