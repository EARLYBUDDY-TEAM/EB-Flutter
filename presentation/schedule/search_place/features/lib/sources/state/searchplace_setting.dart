part of '../../eb_search_place_feature.dart';

sealed class SearchPlaceSetting {}

final class EndSearchPlaceSetting extends SearchPlaceSetting {}

final class StartSearchPlaceSetting extends SearchPlaceSetting {
  final Place endPlace;

  StartSearchPlaceSetting({required this.endPlace});
}
