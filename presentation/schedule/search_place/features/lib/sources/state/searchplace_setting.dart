part of '../../eb_search_place_feature.dart';

sealed class SearchPlaceSetting extends Equatable {}

final class EndSearchPlaceSetting extends SearchPlaceSetting {
  @override
  List<Object?> get props => [];
}

final class StartSearchPlaceSetting extends SearchPlaceSetting {
  final Place endPlace;
  MaterialPageRoute Function(Place) pageFindRoute;

  StartSearchPlaceSetting({
    required this.endPlace,
    required this.pageFindRoute,
  });

  @override
  List<Object?> get props => [
        endPlace,
        pageFindRoute,
      ];
}

final class ChangeEndSearchPlaceSetting extends SearchPlaceSetting {
  @override
  List<Object?> get props => [];
}

final class ChangeStartSearchPlaceSetting extends SearchPlaceSetting {
  @override
  List<Object?> get props => [];
}
