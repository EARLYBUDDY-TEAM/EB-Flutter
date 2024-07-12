part of 'addschedule_bloc.dart';

sealed class AddScheduleEvent extends Equatable {
  const AddScheduleEvent();
}

final class AddScheduleTitleChanged extends AddScheduleEvent {
  final String title;

  const AddScheduleTitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

final class AddScheduleMemoChanged extends AddScheduleEvent {
  final String memo;

  const AddScheduleMemoChanged(this.memo);

  @override
  List<Object?> get props => [memo];
}

final class AddScheduleTimeChanged extends AddScheduleEvent {
  final DateTime time;

  const AddScheduleTimeChanged(this.time);

  @override
  List<Object?> get props => [time];
}

final class AddScheduleIsNotifyChanged extends AddScheduleEvent {
  final bool isNotify;

  const AddScheduleIsNotifyChanged(this.isNotify);

  @override
  List<Object?> get props => [isNotify];
}

final class AddSchedulePressed extends AddScheduleEvent {
  const AddSchedulePressed();

  @override
  List<Object?> get props => [];
}

final class AddScheduleSelectPlace extends AddScheduleEvent {
  final Place place;

  const AddScheduleSelectPlace({required this.place});

  @override
  List<Object?> get props => [place];
}

final class AddScheduleSelectRoute extends AddScheduleEvent {
  final Place place;

  const AddScheduleSelectRoute({required this.place});

  @override
  List<Object?> get props => [place];
}
