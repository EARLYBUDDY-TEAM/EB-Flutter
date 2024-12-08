part of 'request_impl.dart';

final class RegisterRequest {
  static ApiRequest<EmptyDTO> init({
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
}
