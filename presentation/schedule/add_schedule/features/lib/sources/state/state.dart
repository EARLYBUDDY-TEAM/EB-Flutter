part of '../../eb_add_schedule_feature.dart';

final class AddScheduleState extends Equatable {
  final Schedule info;
  final ScheduleInfoStatus status;
  final BaseStatus result;
  final SealedStartPlaceState startPlaceState;

  AddScheduleState({
    Schedule? info,
    ScheduleInfoStatus? status,
    BaseStatus? result,
    SealedStartPlaceState? startPlaceState,
  })  : info = info ?? Schedule(),
        status = status ?? ScheduleInfoStatus.init,
        result = result ?? BaseStatus.init,
        startPlaceState = startPlaceState ?? EmptyStartPlaceState();

  AddScheduleState copyWith({
    Schedule? info,
    ScheduleInfoStatus? status,
    BaseStatus? result,
    SealedStartPlaceState? startPlaceState,
  }) =>
      AddScheduleState(
        info: info ?? this.info,
        status: status ?? this.status,
        result: result ?? this.result,
        startPlaceState: startPlaceState ?? this.startPlaceState,
      );

  @override
  List<Object?> get props => [
        info,
        status,
        result,
        startPlaceState,
      ];
}

enum ScheduleInfoStatus {
  init,
  complete,
  incomplete;
}
