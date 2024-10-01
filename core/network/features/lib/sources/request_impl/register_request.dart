part of 'request_impl.dart';

final class RegisterRequest {
  static ApiRequest<EmptyDTO> init({
    required String name,
    required String email,
    required String password,
  }) {
    final Map<String, dynamic> requestData = {
      'name': name,
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
