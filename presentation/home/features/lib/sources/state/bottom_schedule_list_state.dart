part of '../../eb_home_feature.dart';

final class BottomScheduleListState extends Equatable {
  final List<Schedule> selectedSchedules;

  BottomScheduleListState({
    List<Schedule>? selectedSchedules,
  }) : selectedSchedules = selectedSchedules ?? [];

  static BottomScheduleListState init({
    required DaySchedule daySchedule,
    required CalendarState calendarState,
  }) {
    final selectedSchedules = daySchedule.getValue(
      selectedDay: calendarState.selectedDay,
    );
    return BottomScheduleListState(selectedSchedules: selectedSchedules);
  }

  @override
  List<Object?> get props => [selectedSchedules];
}
