part of '../../eb_home_feature.dart';

sealed class SealedMiddleTransportState extends Equatable {
  static SealedMiddleTransportState init({
    required DaySchedule daySchedule,
    required Stream<RealTimeInfo> Function({required EBSubPath subPath})
        createRealTimeInfoStream,
  }) {
    final closeSchedulePath = daySchedule.getCloseTodaySchedulePath();
    if (closeSchedulePath == null) {
      return AddScheduleMiddleTransportState();
    }

    if (closeSchedulePath.ebPath == null) {
      return AddRouteMiddleTransportState(schedulePath: closeSchedulePath);
    } else {
      // cehckckckckckck
      final subPath = closeSchedulePath.ebPath!.ebSubPaths.first;
      return InfoMiddleTransportState(
        subPath: subPath,
        realTimeInfoStream: createRealTimeInfoStream(subPath: subPath),
      );
    }
  }
}

final class InfoMiddleTransportState extends SealedMiddleTransportState {
  final EBSubPath subPath;
  final Stream<RealTimeInfo> realTimeInfoStream;

  InfoMiddleTransportState({
    required this.subPath,
    required this.realTimeInfoStream,
  });

  @override
  List<Object?> get props => [subPath, realTimeInfoStream];
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
