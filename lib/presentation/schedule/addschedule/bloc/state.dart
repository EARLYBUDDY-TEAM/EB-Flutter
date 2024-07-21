part of 'bloc.dart';

final class AddScheduleState extends Equatable {
  final AddScheduleInfo info;
  final AddScheduleStatus status;

  AddScheduleState({
    AddScheduleInfo? info,
    AddScheduleStatus? status,
  })  : info = info ?? AddScheduleInfo(),
        status = status ?? AddScheduleStatus.init;

  AddScheduleState copyWith({
    AddScheduleInfo? info,
    AddScheduleStatus? status,
  }) =>
      AddScheduleState(
        info: info ?? this.info,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [info, status];
}

enum AddScheduleStatus {
  init,
  complete,
  inComplete;
}

final class AddScheduleInfo extends Equatable {
  final String title;
  final String? memo;
  final DateTime time;
  final bool isNotify;
  Place? startPlace;
  final Place? endPlace;

  AddScheduleInfo({
    String? title,
    this.memo,
    DateTime? time,
    bool? isNotify,
    this.startPlace,
    this.endPlace,
  })  : title = title ?? '',
        time = time ?? DateTime.now(),
        isNotify = isNotify ?? false;

  AddScheduleInfo copyWith({
    String? title,
    String? memo,
    DateTime? time,
    bool? isNotify,
    Place? startPlace,
    Place? endPlace,
  }) =>
      AddScheduleInfo(
        title: title ?? this.title,
        memo: memo ?? this.memo,
        time: time ?? this.time,
        isNotify: isNotify ?? this.isNotify,
        startPlace: startPlace ?? this.startPlace,
        endPlace: endPlace ?? this.endPlace,
      );

  @override
  List<Object?> get props =>
      [title, memo, time, isNotify, startPlace, endPlace];
}

final class SchedulePlace extends Equatable {
  final String? start;
  final String? end;

  const SchedulePlace({
    this.start,
    this.end,
  });

  SchedulePlace copyWith({
    String? start,
    String? end,
  }) =>
      SchedulePlace(
        start: start ?? this.start,
        end: end ?? this.end,
      );

  @override
  List<Object?> get props => [start, end];
}
