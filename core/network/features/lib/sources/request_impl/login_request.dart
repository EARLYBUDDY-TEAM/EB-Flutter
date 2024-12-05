part of 'request_impl.dart';

class LoginRequest {
  static ApiRequest<TokenDTO> init({
    required String email,
    required String password,
    required String fcmToken,
  }) {
    const path = '/auth/login';
    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
      'fcm_token': fcmToken,
    };
    TokenDTO converter(dynamic responseData) => TokenDTO.fromJson(responseData);
    final header = {'application': 'x-www-form-urlencoded'};

    return ApiRequest(
      path: path,
      method: HTTPMethod.post,
      requestData: requestData,
      converter: converter,
      headers: header,
    );
  }
}
