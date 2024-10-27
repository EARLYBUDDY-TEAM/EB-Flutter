part of '../../eb_add_schedule_feature.dart';

sealed class SealedNotifyTransportState extends Equatable {}

final class TrueNotifyTransportState extends SealedNotifyTransportState {
  final int beforeNotifyMinute;
  final int beforeNotifyMinuteRange;

  TrueNotifyTransportState({
    int? beforeNotifyMinute,
    int? beforeNotifyMinuteRange,
  })  : beforeNotifyMinute = beforeNotifyMinute ?? 10,
        beforeNotifyMinuteRange = beforeNotifyMinuteRange ?? 10;

  TrueNotifyTransportState copyWith({
    int? beforeNotifyMinute,
    int? beforeNotifyMinuteRange,
  }) {
    return TrueNotifyTransportState(
      beforeNotifyMinute: beforeNotifyMinute ?? this.beforeNotifyMinute,
      beforeNotifyMinuteRange:
          beforeNotifyMinuteRange ?? this.beforeNotifyMinuteRange,
    );
  }

  @override
  List<Object?> get props => [beforeNotifyMinute, beforeNotifyMinuteRange];
}

final class FalseNotifyTransportState extends SealedNotifyTransportState {
  @override
  List<Object?> get props => [];
}
