part of '../../../eb_find_route_feature.dart';

sealed class SealedFindRouteContentStatus extends Equatable {}

final class EmptyDataFindRouteStatus extends SealedFindRouteContentStatus {
  EmptyDataFindRouteStatus();

  @override
  List<Object?> get props => [];
}

final class SelectFindRouteStatus extends SealedFindRouteContentStatus {
  SelectFindRouteStatus();

  @override
  List<Object?> get props => [];
}

final class DetailFindRouteStatus extends SealedFindRouteContentStatus {
  final List<EBSubPath> subPaths;

  DetailFindRouteStatus({required this.subPaths});

  @override
  List<Object?> get props => [];
}
