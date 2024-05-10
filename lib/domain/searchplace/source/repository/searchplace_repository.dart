import 'package:earlybuddy/core/network/endpoint/endpoint.dart';
import 'package:earlybuddy/core/network/network_service/network_service.dart';
import '../model/model.dart';

final class SearchPlaceRepository {
  final NetworkService service;

  SearchPlaceRepository({NetworkService? networkService})
      : service = networkService ?? NetworkService();

  Future<List<Place>> getPlaces({
    required String searchText,
  }) async {
    final request = SearchPlaceRequest.init(searchText: searchText);
    final PlaceListDTO placeListDTO = await service.request(request);
    final List<Place> places =
        placeListDTO.places.map((p) => Place.fromDTO(placeDTO: p)).toList();
    return places;
  }
}
