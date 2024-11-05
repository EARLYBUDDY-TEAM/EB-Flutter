part of '../dto.dart';

final class EBRouteDTO {
  final int type;
  final List<EBPathDTO> ebPaths;

  EBRouteDTO({
    required this.type,
    required this.ebPaths,
  });

  static EBRouteDTO fromJson(Map<String, dynamic> j) {
    final ebPathList = j['paths'] as List;
    final ebPaths = ebPathList.map((p) => EBPathDTO.fromJson(p)).toList();
    return EBRouteDTO(type: j['type'], ebPaths: ebPaths);
  }

  static EBRouteDTO mock() {
    return EBRouteDTO.fromJson(mockJsonEBRoute);
  }
}

final class EBPathDTO {
  final int type;
  final int time;
  final int walkTime;
  final int payment;
  final int busTransitCount;
  final int subwayTransitCount;
  final List<EBSubPathDTO> ebSubPaths;

  EBPathDTO({
    required this.type,
    required this.time,
    required this.walkTime,
    required this.payment,
    required this.busTransitCount,
    required this.subwayTransitCount,
    required this.ebSubPaths,
  });

  static EBPathDTO fromJson(Map<String, dynamic> j) {
    final ebSubPathList = j['subPaths'] as List;
    final ebSubPaths =
        ebSubPathList.map((s) => EBSubPathDTO.fromJson(s)).toList();
    return EBPathDTO(
      type: j['type'],
      time: j['time'],
      walkTime: j['walkTime'],
      payment: j['payment'],
      busTransitCount: j['busTransitCount'],
      subwayTransitCount: j['subwayTransitCount'],
      ebSubPaths: ebSubPaths,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "time": time,
      "walkTime": walkTime,
      "payment": payment,
      "busTransitCount": busTransitCount,
      "subwayTransitCount": subwayTransitCount,
      "ebSubPaths": ebSubPaths.map((s) => s.toMap()).toList(),
    };
  }

  static EBPathDTO mockDongToGwang() {
    return EBPathDTO.fromJson(dummyPathDongToGwangMap);
  }
}

final class EBSubPathDTO {
  final int type;
  final int time;
  final String startName;
  final String? startX;
  final String? startY;
  final int? startStationID;
  final String endName;
  final int distance;
  final List<TransportDTO>? transports;
  final List<StationDTO>? stations;

  EBSubPathDTO({
    required this.type,
    required this.time,
    required this.startName,
    required this.startX,
    required this.startY,
    required this.startStationID,
    required this.endName,
    required this.distance,
    required this.transports,
    required this.stations,
  });

  static List<TransportDTO>? _transJsonToModel(dynamic data) {
    if (data == null) {
      return null;
    }
    final transList = data as List;
    final trans = transList.map((t) => TransportDTO.fromJson(t)).toList();
    return trans;
  }

  static List<StationDTO>? _stationsJsonToModel(dynamic data) {
    if (data == null) {
      return null;
    }
    final stationList = data as List;
    final stations = stationList.map((s) => StationDTO.fromJson(s)).toList();
    return stations;
  }

  static EBSubPathDTO fromJson(Map<String, dynamic> j) {
    final trans = _transJsonToModel(j['transports']);
    final stations = _stationsJsonToModel(j['stations']);
    return EBSubPathDTO(
      type: j['type'],
      time: j['time'],
      startName: j['startName'],
      startX: j['startX'],
      startY: j['startY'],
      startStationID: j['start_station_id'],
      endName: j['endName'],
      distance: j['distance'],
      transports: trans,
      stations: stations,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "time": time,
      "startName": startName,
      "startX": startX,
      "startY": startY,
      "start_station_id": startStationID,
      "endName": endName,
      "distance": distance,
      "transports": transports?.map((t) => t.toMap()).toList(),
      "stations": stations?.map((s) => s.toMap()).toList(),
    };
  }
}

final class TransportDTO {
  final String? subwayType;
  final String? busNumber;
  final String? busType;

  TransportDTO({
    required this.subwayType,
    required this.busNumber,
    required this.busType,
  });

  static TransportDTO fromJson(Map<String, dynamic> j) {
    return TransportDTO(
      subwayType: j['subwayType'],
      busNumber: j['busNumber'],
      busType: j['busType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "subwayType": subwayType,
      "busNumber": busNumber,
      "busType": busType,
    };
  }
}

final class StationDTO {
  final String name;

  StationDTO({
    required this.name,
  });

  static StationDTO fromJson(Map<String, dynamic> j) {
    return StationDTO(name: j['name']);
  }

  Map<String, dynamic> toMap() {
    return {"name": name};
  }
}
