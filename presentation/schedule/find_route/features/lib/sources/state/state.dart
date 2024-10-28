part of '../../../eb_find_route_feature.dart';

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
