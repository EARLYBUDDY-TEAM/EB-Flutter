part of '../eb_find_route_feature.dart';

sealed class FindRouteEvent extends Equatable {
  const FindRouteEvent();
}

final class GetRouteData extends FindRouteEvent {
  const GetRouteData();

  @override
  List<Object?> get props => [];
}

final class SetFindRouteContentStatus extends FindRouteEvent {
  final SealedFindRouteContentStatus contentStatus;

  const SetFindRouteContentStatus({
    required this.contentStatus,
  });

  @override
  List<Object?> get props => [];
}

final class SetSearchPlaceInfo extends FindRouteEvent {
  final Place? startPlace;
  final Place? endPlace;

  const SetSearchPlaceInfo({
    this.startPlace,
    this.endPlace,
  });

  @override
  List<Object?> get props => [
        startPlace,
        endPlace,
      ];
}

final class CancelViewAction extends FindRouteEvent {
  const CancelViewAction();

  @override
  List<Object?> get props => [];
}

final class PressSelectRouteButton extends FindRouteEvent {
  const PressSelectRouteButton();

  @override
  List<Object?> get props => [];
}

final class SetupFindRouteView extends FindRouteEvent {
  final SealedFindRouteSetting setting;

  const SetupFindRouteView({
    required this.setting,
  });

  @override
  List<Object?> get props => [setting];
}
