part of 'searchplace_bloc.dart';

sealed class SearchPlaceEvent extends Equatable {
  const SearchPlaceEvent();
}

final class SearchPlaceSearchTextChanged extends SearchPlaceEvent {
  final String searchText;

  const SearchPlaceSearchTextChanged(this.searchText);

  @override
  List<Object?> get props => [searchText];
}

final class SearchPlaceListItemPressed extends SearchPlaceEvent {
  final Place place;

  const SearchPlaceListItemPressed({required this.place});

  @override
  List<Object?> get props => [place];
}

final class SearchPlaceSearchButtonPressed extends SearchPlaceEvent {
  @override
  List<Object?> get props => [];
}

final class SearchPlaceSearchResetButtonPressed extends SearchPlaceEvent {
  @override
  List<Object?> get props => [];
}

final class SearchPlaceSelectPlaceButtonPressed extends SearchPlaceEvent {
  final Place selectedPlace;

  const SearchPlaceSelectPlaceButtonPressed({required this.selectedPlace});

  @override
  List<Object?> get props => [selectedPlace];
}

final class SearchPlaceCancelButtonPressed extends SearchPlaceEvent {
  @override
  List<Object?> get props => [];
}
