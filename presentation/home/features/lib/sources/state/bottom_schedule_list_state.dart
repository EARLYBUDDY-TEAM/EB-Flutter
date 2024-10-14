part of '../../eb_home_feature.dart';

final class BottomScheduleListState extends Equatable {
  final List<Schedule> selectedSchedules;

  BottomScheduleListState({
    List<Schedule>? selectedSchedules,
  }) : selectedSchedules = selectedSchedules ?? [];

  @override
  List<Object?> get props => [selectedSchedules];
}
