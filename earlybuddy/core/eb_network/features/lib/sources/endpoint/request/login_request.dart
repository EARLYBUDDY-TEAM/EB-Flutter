part of 'request.dart';

class LoginRequest {
  static ApiRequest<TokenDTO> init({
    required String email,
    required String password,
  }) {
    const path = '/auth/login';
    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
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
