part of '../../eb_search_place_feature.dart';

sealed class SearchPlaceSetting extends Equatable {}

final class EndSearchPlaceSetting extends SearchPlaceSetting {
  @override
  List<Object?> get props => [];
}

final class StartSearchPlaceSetting extends SearchPlaceSetting {
  final Place endPlace;

  StartSearchPlaceSetting({required this.endPlace});

  @override
  List<Object?> get props => [endPlace];
}
