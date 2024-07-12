part of 'request.dart';

final class FindRouteRequest {
  static ApiRequest<EBRouteDTO> init() {
    EBRouteDTO converter(dynamic responseData) =>
        EBRouteDTO.fromJson(responseData);

    return ApiRequest(
      path: '/map/route/find',
      method: HTTPMethod.get,
      converter: converter,
    );
  }
}
