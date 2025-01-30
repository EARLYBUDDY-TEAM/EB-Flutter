part of '../../eb_add_schedule_feature.dart';

sealed class SealedStartPlaceState extends Equatable {}

final class SelectedStartPlaceState extends SealedStartPlaceState {
  final PathState pathInfo;
  final DateTime scheduleTime;

  SelectedStartPlaceState({
    required this.pathInfo,
    required this.scheduleTime,
  });

  @override
  List<Object?> get props => [
        pathInfo,
        scheduleTime,
      ];
}

final class EmptyStartPlaceState extends SealedStartPlaceState {
  @override
  List<Object?> get props => [];
}
