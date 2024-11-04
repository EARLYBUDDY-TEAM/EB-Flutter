part of '../../dto.dart';

final class SchedulePathListDTO {
  final List<SchedulePathDTO> allScheduleDTO;

  SchedulePathListDTO({required this.allScheduleDTO});

  static SchedulePathListDTO fromJson(Map<String, dynamic> j) {
    final tmpAllScheduleDTO = j["all_schedules"] as List;
    final allScheduleDTO = tmpAllScheduleDTO
        .map(
          (c) => SchedulePathDTO.fromJson(c),
        )
        .toList();
    return SchedulePathListDTO(allScheduleDTO: allScheduleDTO);
  }
}

final class SchedulePathDTO {
  final ScheduleDTO scheduleDTO;
  final EBPathDTO? ebPathDTO;

  SchedulePathDTO({
    required this.scheduleDTO,
    required this.ebPathDTO,
  });

  static SchedulePathDTO fromJson(Map<String, dynamic> j) {
    final scheduleDTO = ScheduleDTO.fromJson(j["schedule_info"]);
    final ebPathDTO =
        (j["path_info"] != null) ? EBPathDTO.fromJson(j["path_info"]) : null;

    return SchedulePathDTO(
      scheduleDTO: scheduleDTO,
      ebPathDTO: ebPathDTO,
    );
  }
}
