part of 'request.dart';

final class SearchPlaceRequest {
  static ApiRequest<PlaceListDTO> init({
    required String searchText,
  }) {
    final query = {'search_text': searchText};
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
