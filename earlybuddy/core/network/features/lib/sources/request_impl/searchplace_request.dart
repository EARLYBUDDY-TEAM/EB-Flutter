part of 'request_impl.dart';

final class SearchPlaceRequest {
  static ApiRequest<PlaceListDTO> init({
    required String searchText,
    required String longitudeX,
    required String latitudeY,
  }) {
    final query = {
      'query': searchText,
      'x': longitudeX,
      'y': latitudeY,
    };
    PlaceListDTO converter(dynamic responseData) =>
        PlaceListDTO.fromJson(responseData);

    return ApiRequest(
      path: '/map/place/search',
      method: HTTPMethod.get,
      query: query,
      converter: converter,
    );
  }
}
