part of 'bloc.dart';

final class AddScheduleState extends Equatable {
  final ScheduleInfo info;
  final AddScheduleStatus status;

  AddScheduleState({
    ScheduleInfo? info,
    AddScheduleStatus? status,
  })  : info = info ?? ScheduleInfo(),
        status = status ?? AddScheduleStatus.init;

  AddScheduleState copyWith({
    ScheduleInfo? info,
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
