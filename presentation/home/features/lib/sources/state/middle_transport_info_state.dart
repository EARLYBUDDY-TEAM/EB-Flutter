part of '../../eb_home_feature.dart';

sealed class SealedMiddleTransportState extends Equatable {
  static SealedMiddleTransportState init({
    required DaySchedule daySchedule,
    required Stream<RealTimeInfo> Function({required int stationID})
        realTimeInfoStream,
  }) {
    final closeSchedulePath = daySchedule.getCloseTodaySchedulePath();
    if (closeSchedulePath == null) {
      return AddScheduleMiddleTransportState();
    }

    if (closeSchedulePath.ebPath == null) {
      return AddRouteMiddleTransportState(schedulePath: closeSchedulePath);
    } else {
      // final stationID = closeSchedulePath.ebPath.getFirstStationID;
      const stationID = 0;
      return InfoMiddleTransportState(
        realTimeInfoStream: realTimeInfoStream(stationID: stationID),
      );
    }
  }
}

final class InfoMiddleTransportState extends SealedMiddleTransportState {
  final Stream<RealTimeInfo> realTimeInfoStream;

  InfoMiddleTransportState({
    required this.realTimeInfoStream,
  });

  @override
  List<Object?> get props => [realTimeInfoStream];
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
  final SchedulePath schedulePath;

  AddRouteMiddleTransportState({
    required this.schedulePath,
  });

  @override
  List<Object?> get props => [schedulePath];
}

final class AddScheduleMiddleTransportState extends SealedMiddleTransportState {
  @override
  List<Object?> get props => [];
}
