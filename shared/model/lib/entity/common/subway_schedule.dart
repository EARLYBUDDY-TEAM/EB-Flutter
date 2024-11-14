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

  static Iterable<SubwaySchedule> Function(SubwayScheduleDTO)
      get _subwayScheduleFromDTOInExpand {
    return (dto) {
      final tmpSubwaySchedule = SubwaySchedule.fromDTO(dto: dto);
      return (tmpSubwaySchedule != null) ? [tmpSubwaySchedule] : [];
    };
  }

  static TotalSubwaySchedule fromDTO({required TotalSubwayScheduleDTO dto}) {
    final weekDaySchedule = dto.weekDaySchedule
        .expand<SubwaySchedule>(_subwayScheduleFromDTOInExpand)
        .toList();

    final saturDaySchedule = dto.saturDaySchedule
        .expand<SubwaySchedule>(_subwayScheduleFromDTOInExpand)
        .toList();

    final holidayDaySchedule = dto.holidayDaySchedule
        .expand<SubwaySchedule>(_subwayScheduleFromDTOInExpand)
        .toList();

    return TotalSubwaySchedule(
      weekDaySchedule: weekDaySchedule,
      saturDaySchedule: saturDaySchedule,
      holidayDaySchedule: holidayDaySchedule,
    );
  }

  static TotalSubwaySchedule mock() {
    final dto = TotalSubwayScheduleDTO.mock();
    return TotalSubwaySchedule.fromDTO(dto: dto);
  }
}

final class SubwaySchedule extends Equatable {
  final TimeOfDay departureTime;
  final bool firstLastFlag;

  const SubwaySchedule({
    required this.departureTime,
    required this.firstLastFlag,
  });

  @override
  List<Object?> get props => [
        departureTime,
        firstLastFlag,
      ];

  static SubwaySchedule? fromDTO({
    required SubwayScheduleDTO dto,
  }) {
    final firstLastFlag = (dto.firstLastFlag == 1) ? true : false;
    final departureTime = _deparetureTimeStringToDateTime(dto.departureTime);
    if (departureTime == null) {
      return null;
    }

    return SubwaySchedule(
      departureTime: departureTime,
      firstLastFlag: firstLastFlag,
    );
  }

  static TimeOfDay? _deparetureTimeStringToDateTime(
      String departureTimeString) {
    final List<int> departureTimeList = departureTimeString
        .split(":")
        .map<int>(
          (e) => int.parse(e),
        )
        .toList();

    if (departureTimeList.length != 2) {
      return null;
    }

    final int hour = departureTimeList[0];
    final int minute = departureTimeList[1];
    final departureTime = TimeOfDay(hour: hour, minute: minute);

    return departureTime;
  }
}
