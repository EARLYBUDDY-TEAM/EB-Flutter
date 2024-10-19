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

final class ChangeTime extends AddScheduleEvent {
  final DateTime time;

  const ChangeTime(this.time);

  @override
  List<Object?> get props => [time];
}

final class ChangeNotify extends AddScheduleEvent {
  final bool isNotify;

  const ChangeNotify(this.isNotify);

  @override
  List<Object?> get props => [isNotify];
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
  final PathInfo pathInfo;

  const SelectStartPlace({required this.pathInfo});

  @override
  List<Object?> get props => [pathInfo];
}

final class RemoveStartPlace extends AddScheduleEvent {
  const RemoveStartPlace();

  @override
  List<Object?> get props => [];
}

final class PressAlertOkButton extends AddScheduleEvent {
  const PressAlertOkButton();

  @override
  List<Object?> get props => [];
}

final class SetAddScheduleResult extends AddScheduleEvent {
  final BaseStatus result;

  const SetAddScheduleResult({required this.result});

  @override
  List<Object?> get props => [result];
}
