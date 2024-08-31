part of '../eb_search_place_feature.dart';

sealed class SearchPlaceEvent extends Equatable {
  const SearchPlaceEvent();
}

final class ChangeSearchText extends SearchPlaceEvent {
  final String searchText;

  const ChangeSearchText(this.searchText);

  @override
  List<Object?> get props => [searchText];
}

final class PressListItem extends SearchPlaceEvent {
  final Place place;

  const PressListItem({required this.place});

  @override
  List<Object?> get props => [place];
}

final class PressSearchButton extends SearchPlaceEvent {
  @override
  List<Object?> get props => [];
}

final class PressResetButton extends SearchPlaceEvent {
  @override
  List<Object?> get props => [];
}

final class PressSelectPlaceButton extends SearchPlaceEvent {
  final Place selectedPlace;

  const PressSelectPlaceButton({required this.selectedPlace});

  @override
  List<Object?> get props => [selectedPlace];
}

final class PressCancelButton extends SearchPlaceEvent {
  @override
  List<Object?> get props => [];
}
