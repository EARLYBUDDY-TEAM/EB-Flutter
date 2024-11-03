part of '../../eb_home_feature.dart';

sealed class SealedMiddleTransportState extends Equatable {}

final class InfoMiddleTransportState extends SealedMiddleTransportState {
  final EBSubPath subPath;
  final Stream<RealTimeInfo?> streamRealTimeInfo;

  InfoMiddleTransportState({
    required this.subPath,
    required this.streamRealTimeInfo,
  });

  InfoMiddleTransportState copyWith({
    EBSubPath? subPath,
    Stream<RealTimeInfo?>? streamRealTimeInfo,
  }) {
    return InfoMiddleTransportState(
      subPath: subPath ?? this.subPath,
      streamRealTimeInfo: streamRealTimeInfo ?? this.streamRealTimeInfo,
    );
  }

  @override
  List<Object?> get props => [
        subPath,
        streamRealTimeInfo,
      ];
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
