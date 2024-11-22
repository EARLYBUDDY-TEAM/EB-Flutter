part of '../../../../findroute_feature.dart';

final class RouteInfo extends Equatable {
  final EBRoute ebRoute;
  final TransportLineOfRoute transportLineOfRoute;

  const RouteInfo({
    this.ebRoute = const EBRoute(),
    this.transportLineOfRoute = const TransportLineOfRoute(),
  });

  RouteInfo copyWith({
    EBRoute? ebRoute,
    TransportLineOfRoute? transportLineOfRoute,
  }) {
    return RouteInfo(
      ebRoute: ebRoute ?? this.ebRoute,
      transportLineOfRoute: transportLineOfRoute ?? this.transportLineOfRoute,
    );
  }

  @override
  List<Object?> get props => [
        ebRoute,
        transportLineOfRoute,
      ];
}
