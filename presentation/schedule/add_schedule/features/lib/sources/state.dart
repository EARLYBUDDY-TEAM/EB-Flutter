part of '../eb_add_schedule_feature.dart';

final class AddScheduleState extends Equatable {
  final ScheduleInfo info;
  final ScheduleInfoStatus status;
  final AddScheduleResult result;

  AddScheduleState({
    ScheduleInfo? info,
    ScheduleInfoStatus? status,
    AddScheduleResult? result,
  })  : info = info ?? ScheduleInfo(),
        status = status ?? ScheduleInfoStatus.init,
        result = result ?? AddScheduleResult.init;

  AddScheduleState copyWith({
    ScheduleInfo? info,
    ScheduleInfoStatus? status,
    AddScheduleResult? result,
  }) =>
      AddScheduleState(
        info: info ?? this.info,
        status: status ?? this.status,
        result: result ?? this.result,
      );

  @override
  List<Object?> get props => [info, status, result];
}

enum ScheduleInfoStatus {
  init,
  complete,
  incomplete;
}

enum AddScheduleResult {
  init,
  success,
  fail;
}
