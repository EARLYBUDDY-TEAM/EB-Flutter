part of '../dto.dart';

final class ScheduleListDTO {
  final List<ScheduleDTO> allScheduleDTO;

  ScheduleListDTO({
    required this.allScheduleDTO,
  });

  static ScheduleListDTO fromJson(Map<String, dynamic> j) {
    final tmpAllScheduleDTO = j["all_schedules"] as List;
    final allScheduleDTO = tmpAllScheduleDTO
        .map(
          (c) => ScheduleDTO.fromJson(c),
        )
        .toList();
    return ScheduleListDTO(allScheduleDTO: allScheduleDTO);
  }
}

final class ScheduleDTO {
  final int id;
  final String title;
  final String? memo;
  final String time;
  final bool isNotify;
  final PlaceDTO? startPlaceDTO;
  final PlaceDTO? endPlaceDTO;

  ScheduleDTO({
    required this.id,
    required this.title,
    required this.memo,
    required this.time,
    required this.isNotify,
    required this.startPlaceDTO,
    required this.endPlaceDTO,
  });

  static ScheduleDTO fromJson(Map<String, dynamic> j) {
    final int id = j["id"];
    final String title = j["title"];
    final String? memo = j["memo"];
    final String time = j["time"];
    final bool isNotify = j["isNotify"];
    final Map<String, dynamic>? startPlaceJson = j["startPlaceInfo"];
    PlaceDTO? startPlaceDTO;
    if (startPlaceJson != null) {
      startPlaceDTO = PlaceDTO.fromEBServerJson(startPlaceJson);
    }
    final Map<String, dynamic>? endPlaceJson = j["endPlaceInfo"];
    PlaceDTO? endPlaceDTO;
    if (endPlaceJson != null) {
      endPlaceDTO = PlaceDTO.fromEBServerJson(endPlaceJson);
    }

    return ScheduleDTO(
      id: id,
      title: title,
      memo: memo,
      time: time,
      isNotify: isNotify,
      startPlaceDTO: startPlaceDTO,
      endPlaceDTO: endPlaceDTO,
    );
  }
}
