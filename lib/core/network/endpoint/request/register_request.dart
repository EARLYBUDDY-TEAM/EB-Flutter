part of 'request.dart';

final class RegisterRequest {
  static ApiRequest<EmptyDTO> init({
    required String email,
    required String password,
  }) {
    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    return ApiRequest(
      path: '/auth/register',
      method: HTTPMethod.post,
      requestData: requestData,
    );
  }
}
