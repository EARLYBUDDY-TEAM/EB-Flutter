part of '../../eb_add_schedule_feature.dart';

sealed class SealedNotifyScheduleState extends Equatable {}

final class TrueNotifyScheduleState extends SealedNotifyScheduleState {
  final int beforeNotifyMinute;

  TrueNotifyScheduleState({
    required this.beforeNotifyMinute,
  });

  @override
  List<Object?> get props => [beforeNotifyMinute];
}

final class FalseNotifyScheduleState extends SealedNotifyScheduleState {
  @override
  List<Object?> get props => [];
}
