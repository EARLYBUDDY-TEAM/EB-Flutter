part of 'findroute_bloc.dart';

sealed class FindRouteEvent extends Equatable {
  const FindRouteEvent();
}

final class FetchFindRouteData extends FindRouteEvent {
  const FetchFindRouteData();

  @override
  List<Object?> get props => [];
}
