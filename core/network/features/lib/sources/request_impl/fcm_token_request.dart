part of 'request_impl.dart';

final class FCMTokenRequest {
  static const prefixPath = "/token/fcm";

  static ApiRequest<bool> isAuthorized({
    required String userEmail,
  }) {
    const path = "$prefixPath/is_authorized";
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
    final header = {"fcm_token": fcmToken};

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
