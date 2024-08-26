part of 'request_impl.dart';

final class FindRouteRequest {
  static ApiRequest<EBRouteDTO> init({
    required String sx,
    required String sy,
    required String ex,
    required String ey,
    required String startPlace,
    required String endPlace,
  }) {
    EBRouteDTO converter(dynamic responseData) =>
        EBRouteDTO.fromJson(responseData);

    final query = {
      'sx': sx,
      'sy': sy,
      'ex': ex,
      'ey': ey,
      'startPlace': startPlace,
      'endPlace': endPlace,
    };

    return ApiRequest(
      path: '/map/route/find',
      query: query,
      method: HTTPMethod.get,
      converter: converter,
    );
  }
}
