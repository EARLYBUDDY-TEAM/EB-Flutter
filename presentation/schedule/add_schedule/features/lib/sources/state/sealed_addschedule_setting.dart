part of '../../eb_add_schedule_feature.dart';

sealed class SealedAddScheduleSetting extends Equatable {}

final class ChangeScheduleSetting extends SealedAddScheduleSetting {
  final Schedule schedule;
  final EBPath? ebPath;

  ChangeScheduleSetting({
    required this.schedule,
    required this.ebPath,
  });

  @override
  List<Object?> get props => [
        schedule,
        ebPath,
      ];
}

final class InitScheduleSetting extends SealedAddScheduleSetting {
  @override
  List<Object?> get props => [];
}
