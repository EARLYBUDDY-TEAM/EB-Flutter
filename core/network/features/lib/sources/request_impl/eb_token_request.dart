part of 'request_impl.dart';

final class EBTokenRequest {
  static ApiRequest<TokenDTO> init({
    required String refreshToken,
  }) {
    const path = "/token/eb/recreate";
    TokenDTO converter(dynamic responseData) => TokenDTO.fromJson(responseData);

    return ApiRequest(
      path: path,
      method: HTTPMethod.get,
      headers: {"refresh-token": refreshToken},
      converter: converter,
    );
  }
}
