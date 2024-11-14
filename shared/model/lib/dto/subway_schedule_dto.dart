part of '../dto.dart';

final class TotalSubwayScheduleDTO {
  final List<SubwayScheduleDTO> weekDaySchedule;
  final List<SubwayScheduleDTO> saturDaySchedule;
  final List<SubwayScheduleDTO> holidayDaySchedule;

  TotalSubwayScheduleDTO({
    required this.weekDaySchedule,
    required this.saturDaySchedule,
    required this.holidayDaySchedule,
  });

  static TotalSubwayScheduleDTO fromJson(Map<String, dynamic> j) {
    final tmpWeekDaySchedule = j["weekday_schedule"] as List;
    final weekdaySchedule = tmpWeekDaySchedule
        .map<SubwayScheduleDTO>(
          (w) => SubwayScheduleDTO.fromJson(w),
        )
        .toList();
    final tmpSaturDaySchedule = j["saturday_schedule"] as List;
    final saturdaySchedule = tmpSaturDaySchedule
        .map<SubwayScheduleDTO>(
          (w) => SubwayScheduleDTO.fromJson(w),
        )
        .toList();
    final tmpHolidayDaySchedule = j["holiday_schedule"] as List;
    final holidaySchedule = tmpHolidayDaySchedule
        .map<SubwayScheduleDTO>(
          (w) => SubwayScheduleDTO.fromJson(w),
        )
        .toList();
    return TotalSubwayScheduleDTO(
      weekDaySchedule: weekdaySchedule,
      saturDaySchedule: saturdaySchedule,
      holidayDaySchedule: holidaySchedule,
    );
  }

  static TotalSubwayScheduleDTO mock() {
    return TotalSubwayScheduleDTO.fromJson(dummySubwayScheduleDTO);
  }
}

final class SubwayScheduleDTO {
  final String departureTime;
  final int firstLastFlag;

  SubwayScheduleDTO({
    required this.departureTime,
    required this.firstLastFlag,
  });

  static SubwayScheduleDTO fromJson(Map<String, dynamic> j) {
    final departureTime = j["departure_time"];
    final firstLastFlag = j["first_last_flag"];
    return SubwayScheduleDTO(
      departureTime: departureTime,
      firstLastFlag: firstLastFlag,
    );
  }
}
