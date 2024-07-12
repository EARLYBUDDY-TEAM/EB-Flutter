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
}

final mockJsonEBRoute = {
  "type": 0,
  "paths": [
    {
      "type": 1,
      "time": 43,
      "walkTime": 2,
      "payment": 1600,
      "busTransitCount": 0,
      "subwayTransitCount": 2,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 1,
          "time": 33,
          "transports": [
            {"subwayType": "3호선", "busNumber": null, "busType": null}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 1,
          "time": 8,
          "transports": [
            {"subwayType": "6호선", "busNumber": null, "busType": null}
          ]
        },
        {"type": 3, "time": 1, "transports": null}
      ]
    },
    {
      "type": 2,
      "time": 59,
      "walkTime": 11,
      "payment": 1500,
      "busTransitCount": 1,
      "subwayTransitCount": 0,
      "subPaths": [
        {"type": 3, "time": 3, "transports": null},
        {
          "type": 2,
          "time": 48,
          "transports": [
            {"subwayType": null, "busNumber": "401", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 8, "transports": null}
      ]
    },
    {
      "type": 3,
      "time": 47,
      "walkTime": 6,
      "payment": 1700,
      "busTransitCount": 1,
      "subwayTransitCount": 1,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 1,
          "time": 14,
          "transports": [
            {"subwayType": "3호선", "busNumber": null, "busType": null}
          ]
        },
        {"type": 3, "time": 4, "transports": null},
        {
          "type": 2,
          "time": 27,
          "transports": [
            {"subwayType": null, "busNumber": "421", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 1, "transports": null}
      ]
    },
    {
      "type": 3,
      "time": 48,
      "walkTime": 7,
      "payment": 1700,
      "busTransitCount": 1,
      "subwayTransitCount": 1,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 1,
          "time": 14,
          "transports": [
            {"subwayType": "3호선", "busNumber": null, "busType": null}
          ]
        },
        {"type": 3, "time": 4, "transports": null},
        {
          "type": 2,
          "time": 27,
          "transports": [
            {"subwayType": null, "busNumber": "400", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 2, "transports": null}
      ]
    },
    {
      "type": 3,
      "time": 54,
      "walkTime": 8,
      "payment": 1700,
      "busTransitCount": 1,
      "subwayTransitCount": 1,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 1,
          "time": 30,
          "transports": [
            {"subwayType": "3호선", "busNumber": null, "busType": null}
          ]
        },
        {"type": 3, "time": 5, "transports": null},
        {
          "type": 2,
          "time": 16,
          "transports": [
            {"subwayType": null, "busNumber": "110A", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 2, "transports": null}
      ]
    },
    {
      "type": 3,
      "time": 56,
      "walkTime": 5,
      "payment": 1700,
      "busTransitCount": 1,
      "subwayTransitCount": 1,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 2,
          "time": 49,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ]
        },
        {"type": 3, "time": 3, "transports": null},
        {
          "type": 1,
          "time": 2,
          "transports": [
            {"subwayType": "6호선", "busNumber": null, "busType": null}
          ]
        },
        {"type": 3, "time": 1, "transports": null}
      ]
    },
    {
      "type": 3,
      "time": 47,
      "walkTime": 7,
      "payment": 1600,
      "busTransitCount": 1,
      "subwayTransitCount": 2,
      "subPaths": [
        {"type": 3, "time": 3, "transports": null},
        {
          "type": 1,
          "time": 16,
          "transports": [
            {"subwayType": "수인분당선", "busNumber": null, "busType": null}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 1,
          "time": 6,
          "transports": [
            {"subwayType": "7호선", "busNumber": null, "busType": null}
          ]
        },
        {"type": 3, "time": 3, "transports": null},
        {
          "type": 2,
          "time": 18,
          "transports": [
            {"subwayType": null, "busNumber": "421", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 1, "transports": null}
      ]
    },
    {
      "type": 2,
      "time": 61,
      "walkTime": 4,
      "payment": 1700,
      "busTransitCount": 2,
      "subwayTransitCount": 0,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 2,
          "time": 47,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 2,
          "time": 10,
          "transports": [
            {"subwayType": null, "busNumber": "110A", "busType": "간선"},
            {"subwayType": null, "busNumber": "400", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 3, "transports": null}
      ]
    },
    {
      "type": 2,
      "time": 64,
      "walkTime": 11,
      "payment": 1700,
      "busTransitCount": 2,
      "subwayTransitCount": 0,
      "subPaths": [
        {"type": 3, "time": 3, "transports": null},
        {
          "type": 2,
          "time": 40,
          "transports": [
            {"subwayType": null, "busNumber": "361", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 2,
          "time": 13,
          "transports": [
            {"subwayType": null, "busNumber": "143", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 8, "transports": null}
      ]
    },
    {
      "type": 2,
      "time": 65,
      "walkTime": 6,
      "payment": 1700,
      "busTransitCount": 2,
      "subwayTransitCount": 0,
      "subPaths": [
        {"type": 3, "time": 3, "transports": null},
        {
          "type": 2,
          "time": 49,
          "transports": [
            {"subwayType": null, "busNumber": "402", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 2,
          "time": 10,
          "transports": [
            {"subwayType": null, "busNumber": "110A", "busType": "간선"},
            {"subwayType": null, "busNumber": "400", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 3, "transports": null}
      ]
    },
    {
      "type": 2,
      "time": 62,
      "walkTime": 4,
      "payment": 1700,
      "busTransitCount": 2,
      "subwayTransitCount": 0,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 2,
          "time": 46,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ]
        },
        {"type": 3, "time": 2, "transports": null},
        {
          "type": 2,
          "time": 12,
          "transports": [
            {"subwayType": null, "busNumber": "421", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 1, "transports": null}
      ]
    },
    {
      "type": 2,
      "time": 63,
      "walkTime": 3,
      "payment": 1700,
      "busTransitCount": 3,
      "subwayTransitCount": 0,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 2,
          "time": 18,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 2,
          "time": 31,
          "transports": [
            {"subwayType": null, "busNumber": "420", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 2,
          "time": 11,
          "transports": [
            {"subwayType": null, "busNumber": "110A", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 2, "transports": null}
      ]
    },
    {
      "type": 2,
      "time": 62,
      "walkTime": 2,
      "payment": 1700,
      "busTransitCount": 3,
      "subwayTransitCount": 0,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 2,
          "time": 18,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 2,
          "time": 27,
          "transports": [
            {"subwayType": null, "busNumber": "420", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 2,
          "time": 15,
          "transports": [
            {"subwayType": null, "busNumber": "421", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 1, "transports": null}
      ]
    },
    {
      "type": 2,
      "time": 66,
      "walkTime": 7,
      "payment": 1700,
      "busTransitCount": 3,
      "subwayTransitCount": 0,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 2,
          "time": 18,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ]
        },
        {"type": 3, "time": 4, "transports": null},
        {
          "type": 2,
          "time": 30,
          "transports": [
            {"subwayType": null, "busNumber": "402", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 2,
          "time": 11,
          "transports": [
            {"subwayType": null, "busNumber": "110A", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 2, "transports": null}
      ]
    },
    {
      "type": 2,
      "time": 63,
      "walkTime": 3,
      "payment": 1700,
      "busTransitCount": 3,
      "subwayTransitCount": 0,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 2,
          "time": 18,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 2,
          "time": 27,
          "transports": [
            {"subwayType": null, "busNumber": "420", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 0, "transports": null},
        {
          "type": 2,
          "time": 15,
          "transports": [
            {"subwayType": null, "busNumber": "400", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 2, "transports": null}
      ]
    },
    {
      "type": 2,
      "time": 67,
      "walkTime": 8,
      "payment": 1700,
      "busTransitCount": 3,
      "subwayTransitCount": 0,
      "subPaths": [
        {"type": 3, "time": 1, "transports": null},
        {
          "type": 2,
          "time": 18,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ]
        },
        {"type": 3, "time": 4, "transports": null},
        {
          "type": 2,
          "time": 29,
          "transports": [
            {"subwayType": null, "busNumber": "402", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 2, "transports": null},
        {
          "type": 2,
          "time": 12,
          "transports": [
            {"subwayType": null, "busNumber": "421", "busType": "간선"}
          ]
        },
        {"type": 3, "time": 1, "transports": null}
      ]
    }
  ]
};
