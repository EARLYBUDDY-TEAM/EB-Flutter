part of 'request_impl.dart';

final class AddScheduleRequest {
  static ApiRequest<EmptyDTO> create({
    required String accessToken,
    required Map<String, dynamic> scheduleMap,
    required Map<String, dynamic>? pathMap,
  }) {
    final requrestData = {
      "scheduleInfo": scheduleMap,
      "pathInfo": pathMap,
    };

    log(requrestData.toString());

    return ApiRequest(
      path: '/schedule/create',
      method: HTTPMethod.post,
      headers: {"access_token": accessToken},
      requestData: requrestData,
    );
  }

  static ApiRequest<EmptyDTO> update({
    required String accessToken,
    required Map<String, dynamic> scheduleMap,
    required Map<String, dynamic>? pathMap,
  }) {
    return ApiRequest(
      path: '/schedule/update',
      method: HTTPMethod.patch,
      headers: {"access_token": accessToken},
      requestData: {
        "scheduleInfo": scheduleMap,
        "pathInfo": pathMap,
      },
    );
  }

  static ApiRequest<EmptyDTO> delete({
    required String accessToken,
    required String scheduleID,
  }) {
    final Map<String, String> query = {"schedule_id": scheduleID};
    const path = '/schedule/delete';
    final header = {"access_token": accessToken};

    return ApiRequest(
      path: path,
      query: query,
      headers: header,
      method: HTTPMethod.delete,
    );
  }
}
