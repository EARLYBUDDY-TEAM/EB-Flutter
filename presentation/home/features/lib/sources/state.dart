part of '../eb_home_feature.dart';

final class HomeState extends Equatable {
  final HomeStatus status;
  final ScheduleCardMap scheduleCardMap;

  HomeState({
    HomeStatus? status,
    ScheduleCardMap? scheduleCardMap,
  })  : status = status ?? const HomeStatus(),
        scheduleCardMap = scheduleCardMap ?? ScheduleCardMap();

  @override
  List<Object?> get props => [
        status,
        scheduleCardMap,
      ];

  HomeState copyWith({
    HomeStatus? status,
    ScheduleCardMap? scheduleCardMap,
    List<ScheduleCard>? allSchedule,
  }) =>
      HomeState(
        status: status ?? this.status,
        scheduleCardMap: scheduleCardMap ?? this.scheduleCardMap,
      );
}

final class HomeStatus extends Equatable {
  final BaseStatus login;
  final BaseStatus register;
  final BaseStatus getAllScheduleCard;
  final BaseStatus deleteScheduleCard;

  const HomeStatus({
    BaseStatus? login,
    BaseStatus? register,
    BaseStatus? getAllScheduleCard,
    BaseStatus? deleteScheduleCard,
  })  : login = login ?? BaseStatus.init,
        register = register ?? BaseStatus.init,
        getAllScheduleCard = getAllScheduleCard ?? BaseStatus.init,
        deleteScheduleCard = deleteScheduleCard ?? BaseStatus.init;

  @override
  List<Object?> get props => [
        login,
        register,
        getAllScheduleCard,
        deleteScheduleCard,
      ];

  HomeStatus copyWith({
    BaseStatus? login,
    BaseStatus? register,
    BaseStatus? getAllScheduleCard,
    BaseStatus? deleteScheduleCard,
  }) =>
      HomeStatus(
        login: login ?? this.login,
        register: register ?? this.register,
        getAllScheduleCard: getAllScheduleCard ?? this.getAllScheduleCard,
        deleteScheduleCard: deleteScheduleCard ?? this.deleteScheduleCard,
      );
}

final class ScheduleCardMap extends Equatable {
  final DateTime selectedDay;
  final Map<DateTime, List<ScheduleCard>> data;

  ScheduleCardMap({
    DateTime? selectedDay,
    Map<DateTime, List<ScheduleCard>>? data,
  })  : selectedDay = selectedDay ?? EBTime.dateTimeToDay(DateTime.now()),
        data = data ?? {};

  ScheduleCardMap copyWith({
    DateTime? selectedDay,
    Map<DateTime, List<ScheduleCard>>? data,
  }) {
    return ScheduleCardMap(
      selectedDay: selectedDay ?? this.selectedDay,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [selectedDay, data];

  static ScheduleCardMap initWithCardList({
    DateTime? selectedDay,
    List<ScheduleCard>? scheduleCardList,
  }) {
    final tmpSelectedDay = selectedDay ?? EBTime.dateTimeToDay(DateTime.now());
    Map<DateTime, List<ScheduleCard>> tmpData = {};
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
    return ScheduleCardMap(
      selectedDay: tmpSelectedDay,
      data: tmpData,
    );
  }

  List<ScheduleCard> get getSelectedDayCardList {
    return data.containsKey(selectedDay) ? data[selectedDay]! : [];
  }

  ScheduleCardMap delete(ScheduleCard card) {
    final key = EBTime.dateTimeToDay(card.time);
    if (data.containsKey(key)) {
      final scheduleCardList = data[key]!;
      scheduleCardList.remove(card);
      log("delete success !!!");
    }

    return ScheduleCardMap(
      data: data,
      selectedDay: selectedDay,
    );
  }
}
