part of '../../eb_add_schedule_feature.dart';

sealed class SealedAddScheduleSetting extends Equatable {}

final class ChangeAddScheduleSetting extends SealedAddScheduleSetting {
  final Schedule schedule;
  final EBPath? ebPath;

  ChangeAddScheduleSetting({
    required this.schedule,
    required this.ebPath,
  });

  @override
  List<Object?> get props => [
        schedule,
        ebPath,
      ];
}

final class InitAddScheduleSetting extends SealedAddScheduleSetting {
  @override
  List<Object?> get props => [];
}
