part of 'request.dart';

class LoginRequest {
  static ApiRequest<TokenDTO> init({
    required String email,
    required String password,
  }) {
    final requestData = _LoginInfo(
      email: email,
      password: password,
    ).toJson();
    TokenDTO converter(dynamic responseData) => TokenDTO.fromJson(responseData);

    return ApiRequest(
      path: '/auth/login',
      method: HTTPMethod.post,
      requestData: requestData,
      converter: converter,
      headers: {'application': 'x-www-form-urlencoded'},
    );
  }
}

final class _LoginInfo {
  final String email;
  final String password;

  _LoginInfo({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
