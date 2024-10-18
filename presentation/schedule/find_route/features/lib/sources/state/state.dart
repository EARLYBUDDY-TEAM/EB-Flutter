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

  @override
  List<Object?> get props => [startPlace, endPlace];
}

final class FindRouteState extends Equatable {
  final SearchPlaceInfo searchPlaceInfo;
  final EBRoute? ebRoute;
  final FindRouteViewState viewState;
  final SealedFindRouteContentStatus contentStatus;

  FindRouteState({
    required this.searchPlaceInfo,
    EBRoute? ebRoute,
    FindRouteViewState? viewState,
    SealedFindRouteContentStatus? contentStatus,
  })  : ebRoute = ebRoute,
        viewState = viewState ?? const FindRouteViewState(),
        contentStatus = contentStatus ?? EmptyDataFindRouteStatus();

  FindRouteState copyWith({
    SearchPlaceInfo? searchPlaceInfo,
    EBRoute? Function()? ebRoute,
    FindRouteViewState? viewState,
    SealedFindRouteContentStatus? contentStatus,
  }) {
    return FindRouteState(
      searchPlaceInfo: searchPlaceInfo ?? this.searchPlaceInfo,
      ebRoute: ebRoute != null ? ebRoute() : this.ebRoute,
      viewState: viewState ?? this.viewState,
      contentStatus: contentStatus ?? this.contentStatus,
    );
  }

  @override
  List<Object?> get props => [
        searchPlaceInfo,
        ebRoute,
        viewState,
        contentStatus,
      ];
}
