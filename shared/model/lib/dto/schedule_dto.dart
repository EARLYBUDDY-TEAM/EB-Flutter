part of '../dto.dart';

final class ScheduleDTO {
  final String? id;
  final String title;
  final String? memo;
  final String time;
  final int? notifySchedule;
  final int? notifyTransport;
  final int? notifyTransportRange;
  final PlaceDTO? startPlaceDTO;
  final PlaceDTO? endPlaceDTO;

  ScheduleDTO({
    required this.id,
    required this.title,
    required this.memo,
    required this.time,
    required this.notifySchedule,
    required this.notifyTransport,
    required this.notifyTransportRange,
    required this.startPlaceDTO,
    required this.endPlaceDTO,
  });

  static ScheduleDTO fromJson(Map<String, dynamic> j) {
    final String id = j["id"];
    final String title = j["title"];
    final String? memo = j["memo"];
    final String time = j["time"];
    final int? notifySchedule = j["notify_schedule"];
    final int? notifyTransport = j["notify_transport"];
    final int? notifyTransportRange = j["notify_transport_range"];
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
      notifySchedule: notifySchedule,
      notifyTransport: notifyTransport,
      notifyTransportRange: notifyTransportRange,
      startPlaceDTO: startPlaceDTO,
      endPlaceDTO: endPlaceDTO,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "memo": memo,
      "time": time,
      "notifySchedule": notifySchedule,
      "notifyTransport": notifyTransport,
      "notifyTransportRange": notifyTransportRange,
      "startPlaceDTO": startPlaceDTO?.toMap(),
      "endPlaceDTO": endPlaceDTO?.toMap(),
    };
  }
}
