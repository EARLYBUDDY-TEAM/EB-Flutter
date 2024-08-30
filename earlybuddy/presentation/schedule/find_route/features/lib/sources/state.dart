part of '../../eb_find_route_feature.dart';

enum FindRouteStatus { nodata, selectRoute, detailRoute }

final class FindRouteState extends Equatable {
  final EBRoute? ebRoute;
  final FindRouteViewState viewState;
  final FindRouteStatus status;

  const FindRouteState({
    this.ebRoute,
    this.viewState = const FindRouteViewState(),
    this.status = FindRouteStatus.nodata,
  });

  FindRouteState copyWith({
    EBRoute? Function()? ebRoute,
    FindRouteViewState? viewState,
    FindRouteStatus? status,
  }) {
    return FindRouteState(
      ebRoute: ebRoute != null ? ebRoute() : this.ebRoute,
      viewState: viewState ?? this.viewState,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [ebRoute, viewState, status];
}
