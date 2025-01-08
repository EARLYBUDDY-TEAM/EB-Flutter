part of '../../../middle_transport_feature.dart';

sealed class SealedMiddleTransportViewState extends Equatable {}

final class InfoMiddleTransportViewState
    extends SealedMiddleTransportViewState {
  final int currentIndex;
  final List<InfoMiddleTransportCardState> cardStateList;
  final StreamRealTimeInfo? streamRealTimeInfo;
  final bool reloadTrigger;
  final ImminentCardState imminentCardState;

  InfoMiddleTransportViewState({
    required this.currentIndex,
    required this.cardStateList,
    required this.streamRealTimeInfo,
    this.imminentCardState = const ImminentCardState(),
    this.reloadTrigger = false,
  });

  InfoMiddleTransportViewState copyWith({
    int? currentIndex,
    List<InfoMiddleTransportCardState>? cardStateList,
    Stream<List<RealTimeInfo>>? Function()? streamRealTimeInfo,
    bool? reloadTrigger,
    ImminentCardState? imminentCardState,
  }) {
    return InfoMiddleTransportViewState(
        currentIndex: currentIndex ?? this.currentIndex,
        cardStateList: cardStateList ?? this.cardStateList,
        streamRealTimeInfo: streamRealTimeInfo != null
            ? streamRealTimeInfo()
            : this.streamRealTimeInfo,
        reloadTrigger: reloadTrigger ?? this.reloadTrigger,
        imminentCardState: imminentCardState ?? this.imminentCardState);
  }

  @override
  List<Object?> get props => [
        currentIndex,
        cardStateList,
        streamRealTimeInfo,
        reloadTrigger,
        imminentCardState,
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
