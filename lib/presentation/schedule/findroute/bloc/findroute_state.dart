part of 'findroute_bloc.dart';

final class FindRouteState extends Equatable {
  final EBRoute? ebRoute;

  const FindRouteState({
    EBRoute? ebRoute,
  }) : ebRoute = ebRoute;

  FindRouteState copyWith({
    EBRoute? ebRoute,
  }) {
    return FindRouteState(
      ebRoute: ebRoute ?? this.ebRoute,
    );
  }

  @override
  List<Object?> get props => [ebRoute];
}
