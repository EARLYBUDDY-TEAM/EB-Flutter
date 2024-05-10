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
