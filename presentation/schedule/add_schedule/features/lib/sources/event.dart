part of '../eb_add_schedule_feature.dart';

sealed class AddScheduleEvent extends Equatable {
  const AddScheduleEvent();
}

final class ChangeTitle extends AddScheduleEvent {
  final String title;

  const ChangeTitle(this.title);

  @override
  List<Object?> get props => [title];
}

final class ChangeMemo extends AddScheduleEvent {
  final String memo;

  const ChangeMemo(this.memo);

  @override
  List<Object?> get props => [memo];
}

final class ChangeDate extends AddScheduleEvent {
  final DateTime date;

  const ChangeDate({
    required this.date,
  });

  @override
  List<Object?> get props => [date];
}

final class ChangeTime extends AddScheduleEvent {
  final TimeOfDay time;

  const ChangeTime({
    required this.time,
  });

  @override
  List<Object?> get props => [time];
}

final class ChangeNotifySchedule extends AddScheduleEvent {
  final SealedNotifyScheduleState notifyScheduleState;

  const ChangeNotifySchedule({required this.notifyScheduleState});

  @override
  List<Object?> get props => [notifyScheduleState];
}

final class ChangeNotifyTransport extends AddScheduleEvent {
  final SealedNotifyTransportState notifyTransportState;

  const ChangeNotifyTransport({
    required this.notifyTransportState,
  });

  @override
  List<Object?> get props => [notifyTransportState];
}

final class SetTrueNotifyTransportState extends AddScheduleEvent {
  final int? beforeNotifyMinute;
  final int? beforeNotifyMinuteRange;

  const SetTrueNotifyTransportState({
    this.beforeNotifyMinute,
    this.beforeNotifyMinuteRange,
  });

  @override
  List<Object?> get props => [beforeNotifyMinute, beforeNotifyMinuteRange];
}

final class PressAddScheduleButton extends AddScheduleEvent {
  const PressAddScheduleButton();

  @override
  List<Object?> get props => [];
}

final class SelectEndPlace extends AddScheduleEvent {
  final Place place;

  const SelectEndPlace({required this.place});

  @override
  List<Object?> get props => [place];
}

final class SelectStartPlace extends AddScheduleEvent {
  final PathState pathInfo;

  const SelectStartPlace({required this.pathInfo});

  @override
  List<Object?> get props => [pathInfo];
}

final class RemoveStartPlace extends AddScheduleEvent {
  const RemoveStartPlace();

  @override
  List<Object?> get props => [];
}

final class SetAddScheduleResultStatus extends AddScheduleEvent {
  final SealedAddScheduleResult result;

  const SetAddScheduleResultStatus({required this.result});

  @override
  List<Object?> get props => [result];
}

final class SetupAddScheduleView extends AddScheduleEvent {
  final SealedAddScheduleSetting setting;

  const SetupAddScheduleView({required this.setting});

  @override
  List<Object?> get props => [setting];
}

final class PressDeleteButton extends AddScheduleEvent {
  @override
  List<Object?> get props => [];
}
