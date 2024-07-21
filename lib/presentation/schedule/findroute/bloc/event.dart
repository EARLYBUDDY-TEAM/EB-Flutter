part of 'bloc.dart';

sealed class FindRouteEvent extends Equatable {
  const FindRouteEvent();
}

final class FetchFindRouteData extends FindRouteEvent {
  final Place start;
  final Place end;

  const FetchFindRouteData({
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [start, end];
}

final class setFindRouteStatus extends FindRouteEvent {
  final FindRouteStatus status;

  const setFindRouteStatus({
    required this.status,
  });

  @override
  List<Object?> get props => [];
}
