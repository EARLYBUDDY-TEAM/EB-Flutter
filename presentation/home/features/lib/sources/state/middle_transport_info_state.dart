part of '../../eb_home_feature.dart';

sealed class SealedMiddleTransportState extends Equatable {
  static SealedMiddleTransportState init({
    required DaySchedule daySchedule,
  }) {
    final closeSchedulePath = daySchedule.getCloseTodaySchedulePath();
    if (closeSchedulePath == null) {
      return AddScheduleMiddleTransportState();
    }

    if (closeSchedulePath.ebPath == null) {
      return AddRouteMiddleTransportState();
    } else {
      return InfoMiddleTransportState();
    }
  }
}

final class InfoMiddleTransportState extends SealedMiddleTransportState {
  @override
  List<Object?> get props => [];
}

final class OverScheduleMiddleTransportState
    extends SealedMiddleTransportState {
  @override
  List<Object?> get props => [];
}

final class ArrivalMiddleTransportState extends SealedMiddleTransportState {
  @override
  List<Object?> get props => [];
}

final class AddRouteMiddleTransportState extends SealedMiddleTransportState {
  @override
  List<Object?> get props => [];
}

final class AddScheduleMiddleTransportState extends SealedMiddleTransportState {
  @override
  List<Object?> get props => [];
}
