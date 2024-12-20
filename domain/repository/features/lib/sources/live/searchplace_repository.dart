part of '../../eb_repository.dart';

final class SearchPlaceRepository {
  final NetworkService _networkService;
  final LocationProvider _locationProvider;

  SearchPlaceRepository({
    NetworkService? networkService,
    LocationProvider? locationProvider,
  })  : _networkService = networkService ?? NetworkService.shared,
        _locationProvider = locationProvider ?? LocationProvider.shared;

  Future<NetworkResponse<List<Place>>> getPlaces({
    required String searchText,
  }) async {
    final Coordi coordi = await _locationProvider.getCurrentLocation();
    final request = SearchPlaceRequest.init(
      searchText: searchText,
      longitudeX: coordi.x,
      latitudeY: coordi.y,
    );
    final result = await _networkService.request(request);

    switch (result) {
      case (SuccessResponse()):
        final List<Place> placeList =
            result.model.places.map((p) => Place.fromDTO(placeDTO: p)).toList();
        return result.copyWith<List<Place>>(model: placeList);
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result.copyWith<List<Place>>();
    }
  }
}
