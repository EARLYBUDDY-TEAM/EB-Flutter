import 'package:earlybuddy/core/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/core/network/sources/service/service.dart';
import 'package:earlybuddy/shared/eb_model/entity/entity.dart';
import 'package:earlybuddy/core/provider/location/location_provider.dart';

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
    final result = await service.request(request);

    PlaceListDTO placeListDTO;
    switch (result) {
      case (Success()):
        placeListDTO = result.model;
      case (Failure()):
        throw 'error';
    }

    final List<Place> places =
        placeListDTO.places.map((p) => Place.fromDTO(placeDTO: p)).toList();
    return places;
  }
}
