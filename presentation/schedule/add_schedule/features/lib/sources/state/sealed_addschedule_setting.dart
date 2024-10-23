part of '../../eb_add_schedule_feature.dart';

sealed class SealedAddScheduleSetting extends Equatable {}

final class ChangeScheduleSetting extends SealedAddScheduleSetting {
  final Schedule initialSchedule;

  ChangeScheduleSetting({
    required this.initialSchedule,
  });

  @override
  List<Object?> get props => [initialSchedule];
}

final class InitScheduleSetting extends SealedAddScheduleSetting {
  @override
  List<Object?> get props => [];
}
