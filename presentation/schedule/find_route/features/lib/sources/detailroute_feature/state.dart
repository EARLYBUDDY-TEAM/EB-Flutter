part of '../../detailroute_feature.dart';

final class DetailRouteState extends Equatable {
  final Transport? selectedTransport;
  final StreamRealTimeInfo? streamRealTimeInfo;

  const DetailRouteState({
    this.selectedTransport,
    this.streamRealTimeInfo,
  });

  DetailRouteState copyWith({
    Transport? Function()? selectedTransport,
    StreamRealTimeInfo? Function()? streamRealTimeInfo,
  }) {
    return DetailRouteState(
      selectedTransport: selectedTransport != null ? selectedTransport() : null,
      streamRealTimeInfo:
          streamRealTimeInfo != null ? streamRealTimeInfo() : null,
    );
  }

  @override
  List<Object?> get props => [
        selectedTransport,
        streamRealTimeInfo,
      ];
}
