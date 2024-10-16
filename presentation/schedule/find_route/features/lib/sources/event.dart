part of '../eb_find_route_feature.dart';

sealed class FindRouteEvent extends Equatable {
  const FindRouteEvent();
}

final class GetRouteData extends FindRouteEvent {
  const GetRouteData();

  @override
  List<Object?> get props => [];
}

final class SetFindRouteStatus extends FindRouteEvent {
  final FindRouteStatus status;

  const SetFindRouteStatus({
    required this.status,
  });

  @override
  List<Object?> get props => [];
}

final class OnAppearFindRouteView extends FindRouteEvent {
  const OnAppearFindRouteView();

  @override
  List<Object?> get props => [];
}
