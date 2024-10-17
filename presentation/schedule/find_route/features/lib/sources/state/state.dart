part of '../../../eb_find_route_feature.dart';

final class FindRouteState extends Equatable {
  final Place startPlace;
  final Place endPlace;
  final EBRoute? ebRoute;
  final FindRouteViewState viewState;
  final SealedFindRouteContentStatus contentStatus;

  FindRouteState({
    required this.startPlace,
    required this.endPlace,
    EBRoute? ebRoute,
    FindRouteViewState? viewState,
    SealedFindRouteContentStatus? contentStatus,
  })  : ebRoute = ebRoute,
        viewState = viewState ?? const FindRouteViewState(),
        contentStatus = contentStatus ?? EmptyDataFindRouteStatus();

  FindRouteState copyWith({
    Place? startPlace,
    Place? endPlace,
    EBRoute? Function()? ebRoute,
    FindRouteViewState? viewState,
    SealedFindRouteContentStatus? contentStatus,
  }) {
    return FindRouteState(
      startPlace: startPlace ?? this.startPlace,
      endPlace: endPlace ?? this.endPlace,
      ebRoute: ebRoute != null ? ebRoute() : this.ebRoute,
      viewState: viewState ?? this.viewState,
      contentStatus: contentStatus ?? this.contentStatus,
    );
  }

  @override
  List<Object?> get props => [
        startPlace,
        endPlace,
        ebRoute,
        viewState,
        contentStatus,
      ];
}
