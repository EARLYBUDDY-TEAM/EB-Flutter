import 'package:earlybuddy/core/network/endpoint/response/dto.dart';
import 'package:earlybuddy/core/network/network_service/network_service.dart';

final class EBApiRequest {
  static ApiRequest<EmptyDTO> register({
    required String email,
    required String password,
  }) {
    var requestData = _RegisterInfo(
      email: email,
      password: password,
    ).toJson();

    return ApiRequest(
      path: '/user/create',
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
