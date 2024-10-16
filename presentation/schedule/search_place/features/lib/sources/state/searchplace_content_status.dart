part of '../../eb_search_place_feature.dart';

sealed class SealedSearchPlaceContent extends Equatable {}

final class ListSearchPlaceContent extends SealedSearchPlaceContent {
  final List<Place> placeList;

  ListSearchPlaceContent({List<Place>? placeList})
      : placeList = placeList ?? [];

  @override
  List<Object?> get props => [placeList];
}

final class MapSearchPlaceContent extends SealedSearchPlaceContent {
  final Place selectedPlace;

  MapSearchPlaceContent({
    Place? selectedPlace,
  }) : selectedPlace = selectedPlace ?? Place.mockEnd();

  @override
  List<Object?> get props => [selectedPlace];
}
