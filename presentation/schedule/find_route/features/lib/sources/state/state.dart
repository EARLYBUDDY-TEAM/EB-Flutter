part of '../../../eb_find_route_feature.dart';

final class FindRouteState extends Equatable {
  final SearchPlaceInfo searchPlaceInfo;
  final RouteInfo routeInfo;
  final SealedFindRouteContentStatus contentStatus;

  FindRouteState({
    required this.searchPlaceInfo,
    this.routeInfo = const RouteInfo(),
    SealedFindRouteContentStatus? contentStatus,
  }) : contentStatus = contentStatus ?? EmptyDataFindRouteStatus();

  FindRouteState copyWith({
    SearchPlaceInfo? searchPlaceInfo,
    int? Function()? selectedIndex,
    RouteInfo? routeInfo,
    SealedFindRouteContentStatus? contentStatus,
  }) {
    return FindRouteState(
      searchPlaceInfo: searchPlaceInfo ?? this.searchPlaceInfo,
      routeInfo: routeInfo ?? this.routeInfo,
      contentStatus: contentStatus ?? this.contentStatus,
    );
  }

  SelectFindRouteStatus createSelectContentStatus({
    RouteInfo? routeInfo,
  }) {
    final tmpRouteInfo = routeInfo ?? this.routeInfo;
    final ebPaths = tmpRouteInfo.ebRoute.ebPaths;
    final lineOfPaths = tmpRouteInfo.transportLineOfRoute.lineOfRoute;
    return SelectFindRouteStatus(
      ebPaths: ebPaths,
      lineOfPaths: lineOfPaths,
    );
  }

  DetailFindRouteStatus createDetailContentStatus({
    required int selectedIndex,
    RouteInfo? routeInfo,
  }) {
    final tmpRouteInfo = routeInfo ?? this.routeInfo;
    final subPaths = tmpRouteInfo.ebRoute.ebPaths[selectedIndex].ebSubPaths;
    return DetailFindRouteStatus(
      selectedIndex: selectedIndex,
      subPaths: subPaths,
    );
  }

  @override
  List<Object?> get props => [
        searchPlaceInfo,
        routeInfo,
        contentStatus,
      ];
}
