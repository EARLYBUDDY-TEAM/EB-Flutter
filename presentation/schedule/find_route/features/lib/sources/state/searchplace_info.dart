part of '../../../eb_find_route_feature.dart';

final class SearchPlaceInfo extends Equatable {
  final Place startPlace;
  final Place endPlace;
  final MaterialPageRoute Function(BuildContext context) pageChangeStartPlace;
  final MaterialPageRoute Function(BuildContext context) pageChangeEndPlace;

  const SearchPlaceInfo({
    required this.startPlace,
    required this.endPlace,
    required this.pageChangeStartPlace,
    required this.pageChangeEndPlace,
  });

  SearchPlaceInfo copyWith({
    Place? startPlace,
    Place? endPlace,
  }) =>
      SearchPlaceInfo(
        startPlace: startPlace ?? this.startPlace,
        endPlace: endPlace ?? this.endPlace,
        pageChangeStartPlace: pageChangeStartPlace,
        pageChangeEndPlace: pageChangeEndPlace,
      );

  @override
  List<Object?> get props => [
        startPlace,
        endPlace,
      ];
}
