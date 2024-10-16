part of '../../eb_find_route_feature.dart';

enum FindRouteStatus { nodata, selectRoute, detailRoute }

final class FindRouteState extends Equatable {
  final Place startPlace;
  final Place endPlace;
  final EBRoute? ebRoute;
  final FindRouteViewState viewState;
  final FindRouteStatus status;

  const FindRouteState({
    required this.startPlace,
    required this.endPlace,
    EBRoute? ebRoute,
    FindRouteViewState? viewState,
    FindRouteStatus? status,
  })  : ebRoute = ebRoute,
        viewState = viewState ?? const FindRouteViewState(),
        status = status ?? FindRouteStatus.nodata;

  FindRouteState copyWith({
    Place? startPlace,
    Place? endPlace,
    EBRoute? Function()? ebRoute,
    FindRouteViewState? viewState,
    FindRouteStatus? status,
  }) {
    return FindRouteState(
      startPlace: startPlace ?? this.startPlace,
      endPlace: endPlace ?? this.endPlace,
      ebRoute: ebRoute != null ? ebRoute() : this.ebRoute,
      viewState: viewState ?? this.viewState,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        startPlace,
        endPlace,
        ebRoute,
        viewState,
        status,
      ];
}
