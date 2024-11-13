part of '../../entity.dart';

final class TotalSubwaySchedule extends Equatable {
  final List<SubwaySchedule> weekDaySchedule;
  final List<SubwaySchedule> saturDaySchedule;
  final List<SubwaySchedule> holidayDaySchedule;

  const TotalSubwaySchedule({
    required this.weekDaySchedule,
    required this.saturDaySchedule,
    required this.holidayDaySchedule,
  });

  @override
  List<Object?> get props => [
        weekDaySchedule,
        saturDaySchedule,
        holidayDaySchedule,
      ];

  static TotalSubwaySchedule fromDTO({required TotalSubwayScheduleDTO dto}) {
    final weekDaySchedule = dto.weekDaySchedule
        .map<SubwaySchedule>((w) => SubwaySchedule.fromDTO(dto: w))
        .toList();

    final saturDaySchedule = dto.saturDaySchedule
        .map<SubwaySchedule>((s) => SubwaySchedule.fromDTO(dto: s))
        .toList();

    final holidayDaySchedule = dto.holidayDaySchedule
        .map<SubwaySchedule>((h) => SubwaySchedule.fromDTO(dto: h))
        .toList();

    return TotalSubwaySchedule(
      weekDaySchedule: weekDaySchedule,
      saturDaySchedule: saturDaySchedule,
      holidayDaySchedule: holidayDaySchedule,
    );
  }
}

final class SubwaySchedule extends Equatable {
  final String departureTime;
  final int firstLastFlag;

  const SubwaySchedule({
    required this.departureTime,
    required this.firstLastFlag,
  });

  @override
  List<Object?> get props => [
        departureTime,
        firstLastFlag,
      ];

  SubwaySchedule.fromDTO({required SubwayScheduleDTO dto})
      : departureTime = dto.departureTime,
        firstLastFlag = dto.firstLastFlag;
}
