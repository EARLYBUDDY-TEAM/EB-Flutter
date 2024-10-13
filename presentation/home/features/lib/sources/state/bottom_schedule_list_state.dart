part of '../../eb_home_feature.dart';

final class BottomScheduleListState extends Equatable {
  final DateTime selectedDay;
  final Map<DateTime, List<Schedule>> data;

  BottomScheduleListState({
    DateTime? selectedDay,
    Map<DateTime, List<Schedule>>? data,
  })  : selectedDay = selectedDay ?? EBTime.dateTimeToDay(DateTime.now()),
        data = data ?? {};

  BottomScheduleListState copyWith({
    DateTime? selectedDay,
    Map<DateTime, List<Schedule>>? data,
  }) {
    return BottomScheduleListState(
      selectedDay: selectedDay ?? this.selectedDay,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [selectedDay, data];

  static BottomScheduleListState initWithSchedules({
    DateTime? selectedDay,
    List<Schedule>? scheduleCardList,
  }) {
    final tmpSelectedDay = selectedDay ?? EBTime.dateTimeToDay(DateTime.now());
    Map<DateTime, List<Schedule>> tmpData = {};
    if (scheduleCardList == null) {
      tmpData = {};
    } else {
      for (var scheduleCard in scheduleCardList) {
        final day = EBTime.dateTimeToDay(scheduleCard.time);
        if (tmpData.containsKey(day)) {
          tmpData[day]!.add(scheduleCard);
        } else {
          tmpData[day] = [scheduleCard];
        }
      }
    }
    return BottomScheduleListState(
      selectedDay: tmpSelectedDay,
      data: tmpData,
    );
  }

  List<Schedule> get getSelectedDayCardList {
    return data.containsKey(selectedDay) ? data[selectedDay]! : [];
  }

  BottomScheduleListState delete(Schedule card) {
    final key = EBTime.dateTimeToDay(card.time);
    if (data.containsKey(key)) {
      final scheduleCardList = data[key]!;
      scheduleCardList.remove(card);
    }

    return BottomScheduleListState(
      data: data,
      selectedDay: selectedDay,
    );
  }
}
