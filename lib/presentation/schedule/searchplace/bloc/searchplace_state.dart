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

  @override
  List<Object?> get props => [places];
}
