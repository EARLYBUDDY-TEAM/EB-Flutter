part of 'addschedule_bloc.dart';

final class AddScheduleState extends Equatable {
  final AddScheduleInfo info;
  final AddScheduleStatus status;

  const AddScheduleState({
    required this.info,
    required this.status,
  });

  AddScheduleState.empty()
      : info = AddScheduleInfo(),
        status = AddScheduleStatus.init;

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
  final String? place;
  final String? route;

  AddScheduleInfo({
    String? title,
    this.memo,
    DateTime? time,
    bool? isNotify,
    this.place,
    this.route,
  })  : title = title ?? '',
        time = time ?? DateTime.now(),
        isNotify = isNotify ?? false;

  AddScheduleInfo copyWith({
    String? title,
    String? memo,
    DateTime? time,
    bool? isNotify,
    String? place,
    String? route,
  }) =>
      AddScheduleInfo(
        title: title ?? this.title,
        memo: memo ?? this.memo,
        time: time ?? this.time,
        isNotify: isNotify ?? this.isNotify,
        place: place ?? this.place,
        route: route ?? this.route,
      );

  @override
  List<Object?> get props => [title, memo, time, isNotify, place, route];
}

final class SchedulePlace extends Equatable {
  final String? departure;
  final String? destination;

  const SchedulePlace({
    this.departure,
    this.destination,
  });

  SchedulePlace copyWith({
    String? departure,
    String? destination,
  }) =>
      SchedulePlace(
        departure: departure ?? this.departure,
        destination: destination ?? this.destination,
      );

  @override
  List<Object?> get props => [departure, destination];
}
