part of 'bloc.dart';

final class SearchPlaceState extends Equatable {
  final String searchText;
  final List<Place> places;
  final Place? selectedPlace;
  final ContentStatus status;

  SearchPlaceState({
    String? searchText,
    List<Place>? places,
    Place? selectedPlace,
    ContentStatus? status,
  })  : searchText = searchText ?? '',
        places = places ?? [],
        selectedPlace = selectedPlace,
        status = status ?? ContentStatus.search;

  SearchPlaceState copyWith({
    String? searchText,
    List<Place>? places,
    Place? selectedPlace,
    ContentStatus? status,
  }) {
    return SearchPlaceState(
      searchText: searchText ?? this.searchText,
      places: places ?? this.places,
      selectedPlace: selectedPlace ?? this.selectedPlace,
      status: status ?? this.status,
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
  List<Object?> get props => [places, status, searchText, selectedPlace];
}

enum ContentStatus {
  search,
  map,
}
