part of '../../../eb_find_route_feature.dart';

sealed class SealedFindRouteContentStatus extends Equatable {}

final class EmptyDataFindRouteStatus extends SealedFindRouteContentStatus {
  EmptyDataFindRouteStatus();

  @override
  List<Object?> get props => [];
}

final class SelectFindRouteStatus extends SealedFindRouteContentStatus {
  final List<EBPath> ebPaths;
  final List<TransportLineOfPath> lineOfPaths;

  SelectFindRouteStatus({
    required this.ebPaths,
    required this.lineOfPaths,
  });

  @override
  List<Object?> get props => [
        ebPaths,
        lineOfPaths,
      ];
}

final class DetailFindRouteStatus extends SealedFindRouteContentStatus {
  final int selectedIndex;
  final EBPath path;

  DetailFindRouteStatus({
    required this.selectedIndex,
    required this.path,
  });

  @override
  List<Object?> get props => [
        selectedIndex,
        path,
      ];
}
