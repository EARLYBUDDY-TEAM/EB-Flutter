part of '../dto.dart';

final class ScheduleCardListDTO {
  final List<ScheduleCardDTO> scheduleCardList;

  ScheduleCardListDTO({
    required this.scheduleCardList,
  });

  static ScheduleCardListDTO fromJson(Map<String, dynamic> j) {
    final tmpScheduleCardList = j["scheduleCardList"] as List;
    final scheduleCardList = tmpScheduleCardList
        .map(
          (c) => ScheduleCardDTO.fromJson(c),
        )
        .toList();
    return ScheduleCardListDTO(scheduleCardList: scheduleCardList);
  }
}

final class ScheduleCardDTO {
  final int scheduleID;
  final String title;
  final String time;
  final String? endPlaceName;

  ScheduleCardDTO({
    required this.scheduleID,
    required this.title,
    required this.time,
    required this.endPlaceName,
  });

  static ScheduleCardDTO fromJson(Map<String, dynamic> j) {
    return ScheduleCardDTO(
      scheduleID: j["scheduleID"],
      title: j["title"],
      time: j["time"],
      endPlaceName: j["endPlaceName"],
    );
  }
}
