part of '../../../middle_transport_feature.dart';

sealed class MiddleTransportViewState extends Equatable {}

final class InfoMiddleTransportState extends MiddleTransportViewState {
  final int currentIndex;
  final List<InfoMiddleTransportCardState> cardStateList;
  final Stream<RealTimeInfo?> streamRealTimeInfo;
  final bool reloadTrigger;

  InfoMiddleTransportState({
    required this.currentIndex,
    required this.cardStateList,
    required this.streamRealTimeInfo,
    this.reloadTrigger = false,
  });

  InfoMiddleTransportState copyWith({
    int? currentIndex,
    List<InfoMiddleTransportCardState>? cardStateList,
    Stream<RealTimeInfo?>? streamRealTimeInfo,
    bool? reloadTrigger,
  }) {
    return InfoMiddleTransportState(
      currentIndex: currentIndex ?? this.currentIndex,
      cardStateList: cardStateList ?? this.cardStateList,
      streamRealTimeInfo: streamRealTimeInfo ?? this.streamRealTimeInfo,
      reloadTrigger: reloadTrigger ?? this.reloadTrigger,
    );
  }

  @override
  List<Object?> get props => [
        currentIndex,
        cardStateList,
        streamRealTimeInfo,
        reloadTrigger,
      ];
}

final class AddRouteMiddleTransportState extends MiddleTransportViewState {
  final SchedulePath schedulePath;

  AddRouteMiddleTransportState({
    required this.schedulePath,
  });

  @override
  List<Object?> get props => [schedulePath];
}

final class AddScheduleMiddleTransportState extends MiddleTransportViewState {
  @override
  List<Object?> get props => [];
}
