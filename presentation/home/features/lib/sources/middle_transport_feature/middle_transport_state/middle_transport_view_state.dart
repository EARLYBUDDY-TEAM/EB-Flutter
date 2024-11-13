part of '../../../middle_transport_feature.dart';

sealed class SealedMiddleTransportViewState extends Equatable {}

final class InfoMiddleTransportViewState
    extends SealedMiddleTransportViewState {
  final int currentIndex;
  final List<InfoMiddleTransportCardState> cardStateList;
  final StreamRealTimeInfo? streamBusRealTimeInfo;
  final bool reloadTrigger;

  InfoMiddleTransportViewState({
    required this.currentIndex,
    required this.cardStateList,
    required this.streamBusRealTimeInfo,
    this.reloadTrigger = false,
  });

  InfoMiddleTransportViewState copyWith({
    int? currentIndex,
    List<InfoMiddleTransportCardState>? cardStateList,
    Stream<List<RealTimeInfo>>? Function()? streamBusRealTimeInfo,
    bool? reloadTrigger,
  }) {
    return InfoMiddleTransportViewState(
      currentIndex: currentIndex ?? this.currentIndex,
      cardStateList: cardStateList ?? this.cardStateList,
      streamBusRealTimeInfo: streamBusRealTimeInfo != null
          ? streamBusRealTimeInfo()
          : this.streamBusRealTimeInfo,
      reloadTrigger: reloadTrigger ?? this.reloadTrigger,
    );
  }

  @override
  List<Object?> get props => [
        currentIndex,
        cardStateList,
        streamBusRealTimeInfo,
        reloadTrigger,
      ];
}

final class AddRouteMiddleTransportState
    extends SealedMiddleTransportViewState {
  final SchedulePath schedulePath;

  AddRouteMiddleTransportState({
    required this.schedulePath,
  });

  @override
  List<Object?> get props => [schedulePath];
}

final class AddScheduleMiddleTransportState
    extends SealedMiddleTransportViewState {
  @override
  List<Object?> get props => [];
}
