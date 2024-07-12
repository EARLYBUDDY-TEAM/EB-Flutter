part of '../bloc.dart';

final class FindRouteState extends Equatable {
  final EBRoute? ebRoute;
  final FindRouteViewState viewState;

  const FindRouteState({
    this.ebRoute,
    this.viewState = const FindRouteViewState(),
  });

  FindRouteState copyWith({
    EBRoute? ebRoute,
    FindRouteViewState? viewState,
  }) {
    return FindRouteState(
      ebRoute: ebRoute ?? this.ebRoute,
      viewState: viewState ?? this.viewState,
    );
  }

  @override
  List<Object?> get props => [ebRoute];
}
