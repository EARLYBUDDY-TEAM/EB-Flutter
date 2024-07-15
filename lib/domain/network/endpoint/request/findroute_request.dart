part of 'request.dart';

final class FindRouteRequest {
  static ApiRequest<EBRouteDTO> init({
    required String sx,
    required String sy,
    required String ex,
    required String ey,
  }) {
    EBRouteDTO converter(dynamic responseData) =>
        EBRouteDTO.fromJson(responseData);

    final query = {
      'sx': sx,
      'sy': sy,
      'ex': ex,
      'ey': ey,
    };

    return ApiRequest(
      path: '/map/route/find',
      query: query,
      method: HTTPMethod.get,
      converter: converter,
    );
  }
}
