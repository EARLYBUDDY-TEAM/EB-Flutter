part of '../../eb_add_schedule_feature.dart';

final class AddScheduleState extends Equatable {
  final SealedAddScheduleSetting setting;
  final Schedule schedule;
  final FormStatus status;
  final SealedAddScheduleResult result;
  final SealedStartPlaceState startPlaceState;
  final SealedNotifyScheduleState notifyScheduleState;
  final SealedNotifyTransportState notifyTransportState;

  AddScheduleState({
    SealedAddScheduleSetting? setting,
    Schedule? info,
    FormStatus? status,
    SealedAddScheduleResult? result,
    SealedStartPlaceState? startPlaceState,
    SealedNotifyScheduleState? notifyScheduleState,
    SealedNotifyTransportState? notifyTransportState,
  })  : setting = setting ?? InitAddScheduleSetting(),
        schedule = info ?? Schedule(),
        status = status ?? FormStatus.init,
        result = result ?? SealedAddScheduleResult.init(),
        startPlaceState = startPlaceState ?? EmptyStartPlaceState(),
        notifyScheduleState = notifyScheduleState ?? FalseNotifyScheduleState(),
        notifyTransportState =
            notifyTransportState ?? FalseNotifyTransportState();

  AddScheduleState copyWith({
    SealedAddScheduleSetting? setting,
    Schedule? schedule,
    FormStatus? status,
    SealedAddScheduleResult? result,
    SealedStartPlaceState? startPlaceState,
    SealedNotifyScheduleState? notifyScheduleState,
    SealedNotifyTransportState? notifyTransportState,
  }) =>
      AddScheduleState(
        setting: setting ?? this.setting,
        info: schedule ?? this.schedule,
        status: status ?? this.status,
        result: result ?? this.result,
        startPlaceState: startPlaceState ?? this.startPlaceState,
        notifyScheduleState: notifyScheduleState ?? this.notifyScheduleState,
        notifyTransportState: notifyTransportState ?? this.notifyTransportState,
      );

  @override
  List<Object?> get props => [
        setting,
        schedule,
        status,
        result,
        startPlaceState,
        notifyScheduleState,
        notifyTransportState,
      ];
}
