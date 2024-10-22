part of '../../eb_search_place_feature.dart';

sealed class SealedSearchPlaceContent extends Equatable {}

final class ListSearchPlaceContent extends SealedSearchPlaceContent {
  @override
  List<Object?> get props => [];
}

final class MapSearchPlaceContent extends SealedSearchPlaceContent {
  final Place selectedPlace;

  MapSearchPlaceContent({
    Place? selectedPlace,
  }) : selectedPlace = selectedPlace ?? Place.mockEnd();

  @override
  List<Object?> get props => [selectedPlace];
}
