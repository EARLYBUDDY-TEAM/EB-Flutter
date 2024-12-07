part of '../../../middle_transport_feature.dart';

sealed class SealedMiddleTransportViewState extends Equatable {}

final class InfoMiddleTransportViewState
    extends SealedMiddleTransportViewState {
  final int currentIndex;
  final List<InfoMiddleTransportCardState> cardStateList;
  final StreamRealTimeInfo? streamRealTimeInfo;
  final bool reloadTrigger;
  final bool onTapImminentCard;

  InfoMiddleTransportViewState({
    required this.currentIndex,
    required this.cardStateList,
    required this.streamRealTimeInfo,
    this.onTapImminentCard = false,
    this.reloadTrigger = false,
  });

  InfoMiddleTransportViewState copyWith({
    int? currentIndex,
    List<InfoMiddleTransportCardState>? cardStateList,
    Stream<List<RealTimeInfo>>? Function()? streamRealTimeInfo,
    bool? reloadTrigger,
    bool? onTapImminentCard,
  }) {
    return InfoMiddleTransportViewState(
        currentIndex: currentIndex ?? this.currentIndex,
        cardStateList: cardStateList ?? this.cardStateList,
        streamRealTimeInfo: streamRealTimeInfo != null
            ? streamRealTimeInfo()
            : this.streamRealTimeInfo,
        reloadTrigger: reloadTrigger ?? this.reloadTrigger,
        onTapImminentCard: onTapImminentCard ?? this.onTapImminentCard);
  }

  @override
  List<Object?> get props => [
        currentIndex,
        cardStateList,
        streamRealTimeInfo,
        reloadTrigger,
        onTapImminentCard,
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