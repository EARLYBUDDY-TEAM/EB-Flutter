part of 'searchplace_bloc.dart';

final class SearchPlaceState extends Equatable {
  final String searchText;
  final List<Place> places;
  final SearchPlaceContentStatus status;

  SearchPlaceState({
    String? searchText,
    List<Place>? places,
    SearchPlaceContentStatus? status,
  })  : searchText = searchText ?? '',
        places = places ?? [],
        status = status ?? SearchPlaceContentStatus.search;

  SearchPlaceState copyWith({
    String? searchText,
    List<Place>? places,
    SearchPlaceContentStatus? status,
  }) {
    return SearchPlaceState(
      searchText: searchText ?? this.searchText,
      places: places ?? this.places,
      status: status ?? this.status,
    );
  }

  static SearchPlaceState mock() {
    final places = List<Place>.generate(100, (index) => Place.mock());
    return SearchPlaceState(places: places);
  }

  @override
  List<Object?> get props => [places, status];
}

enum SearchPlaceContentStatus {
  search,
  map,
}
