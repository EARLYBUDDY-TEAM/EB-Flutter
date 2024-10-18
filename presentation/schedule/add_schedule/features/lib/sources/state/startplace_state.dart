part of '../../eb_add_schedule_feature.dart';

sealed class SealedStartPlaceState extends Equatable {}

final class SelectedStartPlaceState extends SealedStartPlaceState {
  @override
  List<Object?> get props => [];
}

final class EmptyStartPlaceState extends SealedStartPlaceState {
  @override
  List<Object?> get props => [];
}
