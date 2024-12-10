part of 'request_impl.dart';

final class AuthRequest {
  static ApiRequest<TokenDTO> login({
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

  static ApiRequest<EmptyDTO> register({
    required String nickName,
    required String email,
    required String password,
  }) {
    final Map<String, dynamic> requestData = {
      'nickName': nickName,
      'email': email,
      'password': password,
    };
    const path = '/auth/register';

    return ApiRequest<EmptyDTO>(
      path: path,
      method: HTTPMethod.post,
      requestData: requestData,
    );
  }

  static ApiRequest<EmptyDTO> changePassword({
    required String email,
    required String password,
  }) {
    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };
    const path = '/auth/change_password';

    return ApiRequest<EmptyDTO>(
      path: path,
      method: HTTPMethod.post,
      requestData: requestData,
    );
  }

  static ApiRequest<EmptyDTO> removeUser({
    required String accessToken,
  }) {
    const path = '/auth/remove_user';
    final header = {'access_token': accessToken};

    return ApiRequest<EmptyDTO>(
      path: path,
      method: HTTPMethod.delete,
      headers: header,
    );
  }
}
