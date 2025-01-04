part of '../../../../findroute_feature.dart';

final class FindRouteState extends Equatable {
  final SearchPlaceInfo searchPlaceInfo;
  final RouteInfo routeInfo;
  final BaseStatus updateResult;
  final SealedFindRouteContentStatus contentStatus;
  final SealedFindRouteSetting setting;
  final DateTime scheduleTime;

  FindRouteState({
    required this.searchPlaceInfo,
    required this.setting,
    required this.scheduleTime,
    this.routeInfo = const RouteInfo(),
    SealedFindRouteContentStatus? contentStatus,
    BaseStatus? updateResult,
  })  : contentStatus = contentStatus ?? EmptyDataFindRouteStatus(),
        updateResult = updateResult ?? BaseStatus.init;

  FindRouteState copyWith({
    SearchPlaceInfo? searchPlaceInfo,
    int? Function()? selectedIndex,
    RouteInfo? routeInfo,
    SealedFindRouteContentStatus? contentStatus,
    BaseStatus? updateResult,
    DateTime? scheduleTime,
  }) {
    return FindRouteState(
      searchPlaceInfo: searchPlaceInfo ?? this.searchPlaceInfo,
      routeInfo: routeInfo ?? this.routeInfo,
      contentStatus: contentStatus ?? this.contentStatus,
      updateResult: updateResult ?? this.updateResult,
      scheduleTime: scheduleTime ?? this.scheduleTime,
      setting: setting,
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
    final path = tmpRouteInfo.ebRoute.ebPaths[selectedIndex];

    return DetailFindRouteStatus(
      selectedIndex: selectedIndex,
      path: path,
    );
  }

  @override
  List<Object?> get props => [
        searchPlaceInfo,
        routeInfo,
        contentStatus,
        updateResult,
        setting,
        scheduleTime,
      ];
}
