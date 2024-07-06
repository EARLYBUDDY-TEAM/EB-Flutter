part of '../../bloc.dart';

class FindRouteViewState extends Equatable {
  final TransportLineOfRoute transportLineOfRoute;

  const FindRouteViewState(
      {this.transportLineOfRoute = const TransportLineOfRoute()});

  @override
  List<Object?> get props => [transportLineOfRoute];
}
