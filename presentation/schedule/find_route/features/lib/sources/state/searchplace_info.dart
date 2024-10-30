part of '../../../eb_find_route_feature.dart';

final class SearchPlaceInfo extends Equatable {
  final Place? startPlace;
  final Place? endPlace;

  const SearchPlaceInfo({
    required this.startPlace,
    required this.endPlace,
  });

  SearchPlaceInfo copyWith({
    Place? Function()? startPlace,
    Place? Function()? endPlace,
  }) =>
      SearchPlaceInfo(
        startPlace: startPlace != null ? startPlace() : this.startPlace,
        endPlace: endPlace != null ? endPlace() : this.endPlace,
      );

  @override
  List<Object?> get props => [
        startPlace,
        endPlace,
      ];
}
