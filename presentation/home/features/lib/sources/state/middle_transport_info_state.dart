part of '../../eb_home_feature.dart';

sealed class SealedMiddleTransportState extends Equatable {}

final class InfoMiddleTransportState extends SealedMiddleTransportState {
  final Transport? selectedTransport;
  final EBSubPath trasnportSubPath;
  final Stream<RealTimeInfo?> streamRealTimeInfo;

  InfoMiddleTransportState({
    required this.selectedTransport,
    required this.trasnportSubPath,
    required this.streamRealTimeInfo,
  });

  InfoMiddleTransportState copyWith({
    Transport? Function()? selectedTransport,
    EBSubPath? trasnportSubPath,
    Stream<RealTimeInfo?>? streamRealTimeInfo,
  }) {
    return InfoMiddleTransportState(
      selectedTransport: selectedTransport != null
          ? selectedTransport()
          : this.selectedTransport,
      trasnportSubPath: trasnportSubPath ?? this.trasnportSubPath,
      streamRealTimeInfo: streamRealTimeInfo ?? this.streamRealTimeInfo,
    );
  }

  @override
  List<Object?> get props => [
        selectedTransport,
        trasnportSubPath,
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
