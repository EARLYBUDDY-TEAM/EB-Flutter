part of 'addschedule_bloc.dart';

final class AddScheduleState extends Equatable {
  final AddScheduleInfo info;
  final AddScheduleStatus status;

  const AddScheduleState({
    required this.info,
    required this.status,
  });

  AddScheduleState.empty()
      : info = AddScheduleInfo.empty(),
        status = AddScheduleStatus.none;

  AddScheduleState copyWith({
    AddScheduleInfo? info,
    AddScheduleStatus? status,
  }) {
    return AddScheduleState(
      info: info ?? this.info,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [info, status];
}

enum AddScheduleStatus {
  none,
  emptyTitle;
}

final class AddScheduleInfo extends Equatable {
  final String title;
  final String? memo;
  final DateTime time;
  final bool isNotify;
  final String? place;
  final String? route;

  const AddScheduleInfo({
    required this.title,
    this.memo,
    required this.time,
    required this.isNotify,
    this.place,
    this.route,
  });

  AddScheduleInfo.empty()
      : title = '',
        memo = null,
        time = DateTime.now(),
        isNotify = false,
        place = null,
        route = null;

  AddScheduleInfo copyWith({
    String? title,
    String? memo,
    DateTime? time,
    bool? isNotify,
    String? place,
    String? route,
  }) {
    return AddScheduleInfo(
      title: title ?? this.title,
      memo: memo ?? this.memo,
      time: time ?? this.time,
      isNotify: isNotify ?? this.isNotify,
      place: place ?? this.place,
      route: route ?? this.route,
    );
  }

  @override
  List<Object?> get props => [title, memo, time, isNotify, place, route];
}
