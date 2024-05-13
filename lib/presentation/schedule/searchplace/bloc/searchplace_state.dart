part of 'searchplace_bloc.dart';

final class SearchPlaceState extends Equatable {
  final String searchText;
  final List<Place> places;
  final Place? selectedPlace;
  final SearchPlaceContentStatus status;

  SearchPlaceState({
    String? searchText,
    List<Place>? places,
    Place? selectedPlace,
    SearchPlaceContentStatus? status,
  })  : searchText = searchText ?? '',
        places = places ?? [],
        selectedPlace = selectedPlace,
        status = status ?? SearchPlaceContentStatus.search;

  SearchPlaceState copyWith({
    String? searchText,
    List<Place>? places,
    Place? selectedPlace,
    SearchPlaceContentStatus? status,
  }) {
    return SearchPlaceState(
      searchText: searchText ?? this.searchText,
      places: places ?? this.places,
      selectedPlace: selectedPlace ?? this.selectedPlace,
      status: status ?? this.status,
    );
  }

  static SearchPlaceState mock() {
    final places = List<Place>.generate(100, (index) => Place.mock());
    return SearchPlaceState(places: places);
  }

  @override
  List<Object?> get props => [places, status, searchText, selectedPlace];
}

enum SearchPlaceContentStatus {
  search,
  map,
}
