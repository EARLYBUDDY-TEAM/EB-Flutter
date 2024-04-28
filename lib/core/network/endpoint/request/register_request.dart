part of 'request.dart';

final class RegisterRequest {
  static ApiRequest<EmptyDTO> init({
    required String email,
    required String password,
  }) {
    final requestData = _RegisterInfo(
      email: email,
      password: password,
    ).toJson();

    return ApiRequest(
      path: '/auth/register',
      method: HTTPMethod.post,
      requestData: requestData,
    );
  }
}

final class _RegisterInfo {
  final String email;
  final String password;

  _RegisterInfo({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
