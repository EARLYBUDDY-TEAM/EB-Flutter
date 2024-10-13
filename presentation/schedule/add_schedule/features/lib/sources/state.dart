part of '../eb_add_schedule_feature.dart';

final class AddScheduleState extends Equatable {
  final Schedule info;
  final ScheduleInfoStatus status;
  final AddScheduleResult result;

  AddScheduleState({
    Schedule? info,
    ScheduleInfoStatus? status,
    AddScheduleResult? result,
  })  : info = info ?? Schedule(),
        status = status ?? ScheduleInfoStatus.init,
        result = result ?? AddScheduleResult.init;

  AddScheduleState copyWith({
    Schedule? info,
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
