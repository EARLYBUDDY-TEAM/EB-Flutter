part of '../../eb_search_place_feature.dart';

final class SearchPlaceState extends Equatable {
  final SearchPlaceSetting setting;
  final String searchText;
  final List<Place> places;
  final Place? selectedPlace;
  final SearchPlaceContentStatus contentStatus;

  SearchPlaceState({
    required this.setting,
    String? searchText,
    List<Place>? places,
    Place? selectedPlace,
    SearchPlaceContentStatus? contentStatus,
  })  : searchText = searchText ?? '',
        places = places ?? [],
        selectedPlace = selectedPlace,
        contentStatus = contentStatus ?? SearchPlaceContentStatus.search;

  SearchPlaceState copyWith({
    String? searchText,
    List<Place>? places,
    Place? selectedPlace,
    SearchPlaceContentStatus? contentStatus,
  }) {
    return SearchPlaceState(
      setting: setting,
      searchText: searchText ?? this.searchText,
      places: places ?? this.places,
      selectedPlace: selectedPlace ?? this.selectedPlace,
      contentStatus: contentStatus ?? this.contentStatus,
    );
  }

  @override
  List<Object?> get props => [
        places,
        searchText,
        selectedPlace,
        setting,
        contentStatus,
      ];
}
