part of '../../detailroute_feature.dart';

sealed class DetailRouteEvent extends Equatable {}

final class SelectTransport extends DetailRouteEvent {
  final Transport selected;

  SelectTransport({
    required this.selected,
  });

  @override
  List<Object?> get props => [selected];
}

final class SetupDetailRoute extends DetailRouteEvent {
  final EBSubPath subPath;

  SetupDetailRoute({
    required this.subPath,
  });

  @override
  List<Object?> get props => [subPath];
}
