part of '../../eb_add_schedule_feature.dart';

final class AddScheduleState extends Equatable {
  final Schedule info;
  final FormStatus status;
  final BaseStatus result;
  final SealedStartPlaceState startPlaceState;
  final SealedNotifyScheduleState notifyScheduleState;
  final SealedNotifyTransportState notifyTransportState;

  AddScheduleState({
    Schedule? info,
    FormStatus? status,
    BaseStatus? result,
    SealedStartPlaceState? startPlaceState,
    SealedNotifyScheduleState? notifyScheduleState,
    SealedNotifyTransportState? notifyTransportState,
  })  : info = info ?? Schedule(),
        status = status ?? FormStatus.init,
        result = result ?? BaseStatus.init,
        startPlaceState = startPlaceState ?? EmptyStartPlaceState(),
        notifyScheduleState = notifyScheduleState ?? FalseNotifyScheduleState(),
        notifyTransportState =
            notifyTransportState ?? FalseNotifyTransportState();

  AddScheduleState copyWith({
    Schedule? info,
    FormStatus? status,
    BaseStatus? result,
    SealedStartPlaceState? startPlaceState,
    SealedNotifyScheduleState? notifyScheduleState,
    SealedNotifyTransportState? notifyTransportState,
  }) =>
      AddScheduleState(
        info: info ?? this.info,
        status: status ?? this.status,
        result: result ?? this.result,
        startPlaceState: startPlaceState ?? this.startPlaceState,
        notifyScheduleState: notifyScheduleState ?? this.notifyScheduleState,
        notifyTransportState: notifyTransportState ?? this.notifyTransportState,
      );

  @override
  List<Object?> get props => [
        info,
        status,
        result,
        startPlaceState,
        notifyScheduleState,
        notifyTransportState,
      ];
}
