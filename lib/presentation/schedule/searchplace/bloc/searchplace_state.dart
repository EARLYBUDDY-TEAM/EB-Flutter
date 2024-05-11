part of 'searchplace_bloc.dart';

final class SearchPlaceState extends Equatable {
  final List<Place> places;

  SearchPlaceState({
    List<Place>? places,
  }) : places = places ?? [];

  SearchPlaceState copyWith({
    List<Place>? places,
  }) {
    return SearchPlaceState(
      places: places ?? this.places,
    );
  }

  static SearchPlaceState mock() {
    final places = List<Place>.generate(100, (index) => Place.mock());
    return SearchPlaceState(places: places);
  }

  @override
  List<Object?> get props => [places];
}
