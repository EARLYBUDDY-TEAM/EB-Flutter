part of '../../../middle_transport_feature.dart';

enum ImminentState {
  notImminent, // 일정 많이 남은경우
  imminent, // 일정 10분전
  overSchedule, // 일정시간을 넘은 경우
}

final class ImminentCardState extends Equatable {
  final bool onTapImminentCard;
  final ImminentState imminentState;
  final DateTime scheduleTime;

  const ImminentCardState({
    required this.scheduleTime,
    this.onTapImminentCard = false,
    this.imminentState = ImminentState.notImminent,
  });

  ImminentCardState copyWith({
    bool? onTapImminentCard,
    ImminentState? imminentState,
    DateTime? scheduleTime,
  }) {
    return ImminentCardState(
      onTapImminentCard: onTapImminentCard ?? this.onTapImminentCard,
      imminentState: imminentState ?? this.imminentState,
      scheduleTime: scheduleTime ?? this.scheduleTime,
    );
  }

  @override
  List<Object?> get props => [
        onTapImminentCard,
        imminentState,
        scheduleTime,
      ];
}
