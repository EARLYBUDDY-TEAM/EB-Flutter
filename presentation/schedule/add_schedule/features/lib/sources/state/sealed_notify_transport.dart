part of '../../eb_add_schedule_feature.dart';

sealed class SealedNotifyTransportState extends Equatable {}

final class TrueNotifyTransportState extends SealedNotifyTransportState {
  @override
  List<Object?> get props => [];
}

final class FalseNotifyTransportState extends SealedNotifyTransportState {
  @override
  List<Object?> get props => [];
}
