part of '../../../eb_find_route_feature.dart';

class FindRouteViewState extends Equatable {
  final TransportLineOfRoute transportLineOfRoute;

  const FindRouteViewState(
      {this.transportLineOfRoute = const TransportLineOfRoute()});

  @override
  List<Object?> get props => [transportLineOfRoute];
}
