part of '../../eb_home_feature.dart';

final class CalendarState extends Equatable {
  final DateTime selectedDay;

  CalendarState({
    DateTime? selectedDay,
  }) : selectedDay = selectedDay ?? DateTime.now();

  @override
  List<Object?> get props => [selectedDay];

  CalendarState copyWith({
    DateTime? selectedDay,
  }) {
    return CalendarState(
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}
