import 'package:earlybuddy/domain/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/domain/network/sources/network_service/network_service.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/provider/location/location_provider.dart';

final class SearchPlaceRepository {
  final NetworkService service;
  final LocationProvider locationProvider;

  SearchPlaceRepository({
    NetworkService? networkService,
    LocationProvider? locationProvider,
  })  : service = networkService ?? NetworkService.shared,
        locationProvider = locationProvider ?? LocationProvider.shared;

  Future<List<Place>> getPlaces({
    required String searchText,
  }) async {
    final Coordi coordi = await locationProvider.getCurrentLocation();
    final request = SearchPlaceRequest.init(
      searchText: searchText,
      longitudeX: coordi.x,
      latitudeY: coordi.y,
    );
    final PlaceListDTO placeListDTO = await service.request(request);
    final List<Place> places =
        placeListDTO.places.map((p) => Place.fromDTO(placeDTO: p)).toList();
    return places;
  }
}
