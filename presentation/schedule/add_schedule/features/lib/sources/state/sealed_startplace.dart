part of '../../eb_add_schedule_feature.dart';

sealed class SealedStartPlaceState extends Equatable {}

final class SelectedStartPlaceState extends SealedStartPlaceState {
  final PathState pathInfo;

  SelectedStartPlaceState({
    required this.pathInfo,
  });

  @override
  List<Object?> get props => [pathInfo];
}

final class EmptyStartPlaceState extends SealedStartPlaceState {
  @override
  List<Object?> get props => [];
}
