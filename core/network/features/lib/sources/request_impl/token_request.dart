part of 'request_impl.dart';

final class TokenRequest {
  static ApiRequest<TokenDTO> init({
    required String refreshToken,
  }) {
    const path = "/token/recreate";
    TokenDTO converter(dynamic responseData) => TokenDTO.fromJson(responseData);

    return ApiRequest(
      path: path,
      method: HTTPMethod.get,
      headers: {"refresh_token": refreshToken},
      converter: converter,
    );
  }
}
