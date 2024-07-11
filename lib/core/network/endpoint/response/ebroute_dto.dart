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
}

final class EBSubPathDTO {
  final int type;
  final int time;
  final List<TransportDTO>? transports;

  EBSubPathDTO({
    required this.type,
    required this.time,
    required this.transports,
  });

  static List<TransportDTO>? _transJsonToModel(dynamic data) {
    if (data == null) {
      return null;
    }
    final transList = data as List;
    final trans = transList.map((t) => TransportDTO.fromJson(t)).toList();
    return trans;
  }

  static EBSubPathDTO fromJson(Map<String, dynamic> j) {
    final trans = _transJsonToModel(j['transports']);
    return EBSubPathDTO(
      type: j['type'],
      time: j['time'],
      transports: trans,
    );
  }
}

final class TransportDTO {
  final String? subwayName;
  final String? busName;

  TransportDTO({
    required this.subwayName,
    required this.busName,
  });

  static TransportDTO fromJson(Map<String, dynamic> j) {
    return TransportDTO(
      subwayName: j['subwayName'],
      busName: j['busNumber'],
    );
  }
}
