part of '../request_impl.dart';

final class NotiStatusRequest {
  static const prefixPath = "/menu/noti_status";

  static ApiRequest<bool> get({
    required String userEmail,
  }) {
    const path = "$prefixPath/get";
    final query = {"user_email": userEmail};
    bool converter(dynamic responseData) {
      final converted = responseData as bool;
      return converted;
    }

    return ApiRequest(
      path: path,
      query: query,
      method: HTTPMethod.get,
      converter: converter,
    );
  }

  static ApiRequest<EmptyDTO> enable({
    required String userEmail,
    required String fcmToken,
  }) {
    const path = "$prefixPath/enable";
    final query = {"user_email": userEmail};
    final header = {"fcm-token": fcmToken};

    return ApiRequest(
      path: path,
      query: query,
      headers: header,
      method: HTTPMethod.post,
    );
  }

  static ApiRequest<EmptyDTO> disable({
    required String userEmail,
  }) {
    const path = "$prefixPath/disable";
    final query = {"user_email": userEmail};

    return ApiRequest(
      path: path,
      query: query,
      method: HTTPMethod.post,
    );
  }
}
