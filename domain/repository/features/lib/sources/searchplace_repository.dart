part of '../eb_repository.dart';

final class SearchPlaceRepository {
  final NetworkService service;
  final LocationProvider locationProvider;

  SearchPlaceRepository({
    NetworkService? networkService,
    LocationProvider? locationProvider,
  })  : service = networkService ?? NetworkService.shared,
        locationProvider = locationProvider ?? LocationProvider.shared;

  Future<Result> getPlaces({
    required String searchText,
  }) async {
    final Coordi coordi = await locationProvider.getCurrentLocation();
    final request = SearchPlaceRequest.init(
      searchText: searchText,
      longitudeX: coordi.x,
      latitudeY: coordi.y,
    );
    final result = await service.request(request);

    switch (result) {
      case (Success()):
        final PlaceListDTO dto = result.success.model;
        final List<Place> placeList =
            dto.places.map((p) => Place.fromDTO(placeDTO: p)).toList();
        return Success(
          success: SuccessResponse(
            model: placeList,
            statusCode: result.success.statusCode,
          ),
        );
      case (Failure()):
        log(result.failure.error.toString());
        return result;
    }
  }
}
