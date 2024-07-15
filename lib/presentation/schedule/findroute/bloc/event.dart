part of 'bloc.dart';

sealed class FindRouteEvent extends Equatable {
  const FindRouteEvent();
}

final class FetchFindRouteData extends FindRouteEvent {
  final Coordi start;
  final Coordi end;

  const FetchFindRouteData({
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [start, end];
}
