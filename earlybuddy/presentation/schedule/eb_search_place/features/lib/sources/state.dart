part of '../eb_search_place_feature.dart';

final class SearchPlaceState extends Equatable {
  final String searchText;
  final List<Place> places;
  final Place? selectedPlace;
  final SearchPlaceViewState viewState;

  SearchPlaceState({
    String? searchText,
    List<Place>? places,
    Place? selectedPlace,
    SearchPlaceViewState? viewState,
  })  : searchText = searchText ?? '',
        places = places ?? [],
        selectedPlace = selectedPlace,
        viewState = viewState ?? const SearchPlaceViewState();

  SearchPlaceState copyWith({
    String? searchText,
    List<Place>? places,
    Place? selectedPlace,
    SearchPlaceViewState? viewState,
  }) {
    return SearchPlaceState(
      searchText: searchText ?? this.searchText,
      places: places ?? this.places,
      selectedPlace: selectedPlace ?? this.selectedPlace,
      viewState: viewState ?? this.viewState,
    );
  }

  static SearchPlaceState mockView() {
    final places = List<Place>.generate(100, (index) => Place.mockView());
    return SearchPlaceState(places: places);
  }

  static SearchPlaceState mockStarBucks() {
    final places = List<Place>.generate(100, (index) => Place.mockStarBucks());
    return SearchPlaceState(places: places);
  }

  @override
  List<Object?> get props => [
        places,
        searchText,
        selectedPlace,
        viewState,
      ];
}
