part of '../../eb_add_schedule_feature.dart';

sealed class SealedAddScheduleResult extends Equatable {
  static CreateAddScheduleResult init() {
    return CreateAddScheduleResult(status: BaseStatus.init);
  }
}

final class CreateAddScheduleResult extends SealedAddScheduleResult {
  final BaseStatus status;

  CreateAddScheduleResult({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}

final class UpdateAddScheduleResult extends SealedAddScheduleResult {
  final BaseStatus status;

  UpdateAddScheduleResult({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}

final class DeleteAddScheduleResult extends SealedAddScheduleResult {
  final BaseStatus status;

  DeleteAddScheduleResult({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
