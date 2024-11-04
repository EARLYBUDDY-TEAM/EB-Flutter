part of '../../dto.dart';

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

final class StationDTO {
  final String name;

  StationDTO({
    required this.name,
  });

  static StationDTO fromJson(Map<String, dynamic> j) {
    return StationDTO(name: j['name']);
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
        {
          "type": 3,
          "time": 1,
          "startName": "멜로즈",
          "endName": "수서",
          "distance": 95,
          "transports": null,
          "stations": null
        },
        {
          "type": 1,
          "time": 33,
          "startName": "수서",
          "endName": "약수",
          "distance": 19100,
          "transports": [
            {"subwayType": "3호선", "busNumber": null, "busType": null}
          ],
          "stations": [
            {"name": "수서"},
            {"name": "일원"},
            {"name": "대청"},
            {"name": "학여울"},
            {"name": "대치"},
            {"name": "도곡"},
            {"name": "매봉"},
            {"name": "양재"},
            {"name": "남부터미널"},
            {"name": "교대"},
            {"name": "고속터미널"},
            {"name": "잠원"},
            {"name": "신사"},
            {"name": "압구정"},
            {"name": "옥수"},
            {"name": "금호"},
            {"name": "약수"}
          ]
        },
        {
          "type": 3,
          "time": 0,
          "startName": "약수",
          "endName": "약수",
          "distance": 0,
          "transports": null,
          "stations": null
        },
        {
          "type": 1,
          "time": 8,
          "startName": "약수",
          "endName": "이태원",
          "distance": 2700,
          "transports": [
            {"subwayType": "6호선", "busNumber": null, "busType": null}
          ],
          "stations": [
            {"name": "약수"},
            {"name": "버티고개"},
            {"name": "한강진"},
            {"name": "이태원"}
          ]
        },
        {
          "type": 3,
          "time": 1,
          "startName": "이태원",
          "endName": "수서역",
          "distance": 2,
          "transports": null,
          "stations": null
        }
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
        {
          "type": 3,
          "time": 3,
          "startName": "멜로즈",
          "endName": "수서역1번출구",
          "distance": 220,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 48,
          "startName": "수서역1번출구",
          "endName": "용산구청",
          "distance": 14875,
          "transports": [
            {"subwayType": null, "busNumber": "401", "busType": "간선"}
          ],
          "stations": [
            {"name": "수서역1번출구"},
            {"name": "궁마을"},
            {"name": "태화기독교.사회복지관"},
            {"name": "수서삼성아파트앞"},
            {"name": "일원본동주민센터"},
            {"name": "푸른마을아파트앞"},
            {"name": "일원초등학교"},
            {"name": "대치아파트.대모산입구역3번출구"},
            {"name": "쌍용아파트"},
            {"name": "새마을운동중앙회"},
            {"name": "총회회관.휘문고입구"},
            {"name": "삼성역"},
            {"name": "삼성역7번출구"},
            {"name": "봉은사역3번출구.삼성1파출소"},
            {"name": "청담역.경기고교"},
            {"name": "진흥아파트"},
            {"name": "강남구청.강남세무서"},
            {"name": "청담동래미안아파트"},
            {"name": "강남구청역"},
            {"name": "세관앞"},
            {"name": "학동역6번출구"},
            {"name": "영동시장"},
            {"name": "논현역7번출구"},
            {"name": "반포역"},
            {"name": "고속터미널"},
            {"name": "반포대교남단.한강시민공원입구"},
            {"name": "한강중학교"},
            {"name": "용산구청"}
          ]
        },
        {
          "type": 3,
          "time": 8,
          "startName": "용산구청",
          "endName": "수서역",
          "distance": 553,
          "transports": null,
          "stations": null
        }
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
        {
          "type": 3,
          "time": 1,
          "startName": "멜로즈",
          "endName": "수서",
          "distance": 95,
          "transports": null,
          "stations": null
        },
        {
          "type": 1,
          "time": 14,
          "startName": "수서",
          "endName": "양재",
          "distance": 7500,
          "transports": [
            {"subwayType": "3호선", "busNumber": null, "busType": null}
          ],
          "stations": [
            {"name": "수서"},
            {"name": "일원"},
            {"name": "대청"},
            {"name": "학여울"},
            {"name": "대치"},
            {"name": "도곡"},
            {"name": "매봉"},
            {"name": "양재"}
          ]
        },
        {
          "type": 3,
          "time": 4,
          "startName": "양재",
          "endName": "뱅뱅사거리",
          "distance": 256,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 27,
          "startName": "뱅뱅사거리",
          "endName": "이태원역.보광동입구",
          "distance": 8049,
          "transports": [
            {"subwayType": null, "busNumber": "421", "busType": "간선"}
          ],
          "stations": [
            {"name": "뱅뱅사거리"},
            {"name": "래미안아파트.파이낸셜뉴스"},
            {"name": "신분당선강남역"},
            {"name": "지하철2호선강남역"},
            {"name": "논현역"},
            {"name": "신사역"},
            {"name": "한남대교전망카페"},
            {"name": "순천향병원입구"},
            {"name": "한남역.용산노인종합복지관"},
            {"name": "한남동하이페리온"},
            {"name": "보광동신동아아파트"},
            {"name": "기업은행보광동지점"},
            {"name": "한국폴리텍1대학"},
            {"name": "이태원역.보광동입구"}
          ]
        },
        {
          "type": 3,
          "time": 1,
          "startName": "이태원역.보광동입구",
          "endName": "수서역",
          "distance": 88,
          "transports": null,
          "stations": null
        }
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
        {
          "type": 3,
          "time": 1,
          "startName": "멜로즈",
          "endName": "수서",
          "distance": 95,
          "transports": null,
          "stations": null
        },
        {
          "type": 1,
          "time": 14,
          "startName": "수서",
          "endName": "양재",
          "distance": 7500,
          "transports": [
            {"subwayType": "3호선", "busNumber": null, "busType": null}
          ],
          "stations": [
            {"name": "수서"},
            {"name": "일원"},
            {"name": "대청"},
            {"name": "학여울"},
            {"name": "대치"},
            {"name": "도곡"},
            {"name": "매봉"},
            {"name": "양재"}
          ]
        },
        {
          "type": 3,
          "time": 4,
          "startName": "양재",
          "endName": "뱅뱅사거리",
          "distance": 256,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 27,
          "startName": "뱅뱅사거리",
          "endName": "이태원역.보광동 입구",
          "distance": 8181,
          "transports": [
            {"subwayType": null, "busNumber": "400", "busType": "간선"}
          ],
          "stations": [
            {"name": "뱅뱅사거리"},
            {"name": "래미안아파트.파이낸셜뉴스"},
            {"name": "신분당선강남역"},
            {"name": "지하철2호선강남역"},
            {"name": "논현역"},
            {"name": "신사역"},
            {"name": "한남대교전망카페"},
            {"name": "한남5거리"},
            {"name": "순천향대학병원"},
            {"name": "한강진역.블루스퀘어"},
            {"name": "한남동주민센터"},
            {"name": "이태원119안전센터"},
            {"name": "이태원역.보광동 입구"}
          ]
        },
        {
          "type": 3,
          "time": 2,
          "startName": "이태원역.보광동 입구",
          "endName": "수서역",
          "distance": 106,
          "transports": null,
          "stations": null
        }
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
        {
          "type": 3,
          "time": 1,
          "startName": "멜로즈",
          "endName": "수서",
          "distance": 95,
          "transports": null,
          "stations": null
        },
        {
          "type": 1,
          "time": 30,
          "startName": "수서",
          "endName": "옥수",
          "distance": 17500,
          "transports": [
            {"subwayType": "3호선", "busNumber": null, "busType": null}
          ],
          "stations": [
            {"name": "수서"},
            {"name": "일원"},
            {"name": "대청"},
            {"name": "학여울"},
            {"name": "대치"},
            {"name": "도곡"},
            {"name": "매봉"},
            {"name": "양재"},
            {"name": "남부터미널"},
            {"name": "교대"},
            {"name": "고속터미널"},
            {"name": "잠원"},
            {"name": "신사"},
            {"name": "압구정"},
            {"name": "옥수"}
          ]
        },
        {
          "type": 3,
          "time": 5,
          "startName": "옥수",
          "endName": "옥수삼성아파트.래미안옥수리버젠",
          "distance": 346,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 16,
          "startName": "옥수삼성아파트.래미안옥수리버젠",
          "endName": "이태원역1번출구.해밀턴호텔",
          "distance": 3949,
          "transports": [
            {"subwayType": null, "busNumber": "110A", "busType": "간선"}
          ],
          "stations": [
            {"name": "옥수삼성아파트.래미안옥수리버젠"},
            {"name": "옥정중학교입구"},
            {"name": "한남시범아파트"},
            {"name": "한남동"},
            {"name": "순천향대학병원"},
            {"name": "한강진역.블루스퀘어"},
            {"name": "한남동주민센터"},
            {"name": "이태원119안전센터"},
            {"name": "이태원역1번출구.해밀턴호텔"}
          ]
        },
        {
          "type": 3,
          "time": 2,
          "startName": "이태원역1번출구.해밀턴호텔",
          "endName": "수서역",
          "distance": 136,
          "transports": null,
          "stations": null
        }
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
        {
          "type": 3,
          "time": 1,
          "startName": "멜로즈",
          "endName": "수서역현대벤쳐빌",
          "distance": 89,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 49,
          "startName": "수서역현대벤쳐빌",
          "endName": "서울시중부기술교육원.블루스퀘어",
          "distance": 15212,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ],
          "stations": [
            {"name": "수서역현대벤쳐빌"},
            {"name": "수서역"},
            {"name": "일원주유소.삼성서울병원후문"},
            {"name": "삼성서울병원사거리"},
            {"name": "개포자이프레지던스"},
            {"name": "개포주공5단지경기여고"},
            {"name": "개포동역6번출구.개포시장"},
            {"name": "대치역6번출구.강남구민회관"},
            {"name": "은마아파트"},
            {"name": "은마파출소"},
            {"name": "대치현대아파트"},
            {"name": "대치사거리"},
            {"name": "포스코사거리"},
            {"name": "한별구립어린이집"},
            {"name": "센트럴아이파크.강남구도시관리공단"},
            {"name": "강남구청.강남세무서"},
            {"name": "청담동래미안아파트"},
            {"name": "강남구청역"},
            {"name": "영동고교앞"},
            {"name": "씨네시티앞"},
            {"name": "도산공원사거리"},
            {"name": "도산공원"},
            {"name": "신구중학교"},
            {"name": "현대아파트"},
            {"name": "광림교회.현대고등학교"},
            {"name": "신사중학교"},
            {"name": "한남대교전망카페"},
            {"name": "한남5거리"},
            {"name": "순천향대학병원"},
            {"name": "서울시중부기술교육원.블루스퀘어"}
          ]
        },
        {
          "type": 3,
          "time": 3,
          "startName": "서울시중부기술교육원.블루스퀘어",
          "endName": "한강진",
          "distance": 202,
          "transports": null,
          "stations": null
        },
        {
          "type": 1,
          "time": 2,
          "startName": "한강진",
          "endName": "이태원",
          "distance": 1000,
          "transports": [
            {"subwayType": "6호선", "busNumber": null, "busType": null}
          ],
          "stations": [
            {"name": "한강진"},
            {"name": "이태원"}
          ]
        },
        {
          "type": 3,
          "time": 1,
          "startName": "이태원",
          "endName": "수서역",
          "distance": 2,
          "transports": null,
          "stations": null
        }
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
        {
          "type": 3,
          "time": 3,
          "startName": "멜로즈",
          "endName": "수서",
          "distance": 183,
          "transports": null,
          "stations": null
        },
        {
          "type": 1,
          "time": 16,
          "startName": "수서",
          "endName": "강남구청",
          "distance": 8000,
          "transports": [
            {"subwayType": "수인분당선", "busNumber": null, "busType": null}
          ],
          "stations": [
            {"name": "수서"},
            {"name": "대모산입구"},
            {"name": "개포동"},
            {"name": "구룡"},
            {"name": "도곡"},
            {"name": "한티"},
            {"name": "선릉"},
            {"name": "선정릉"},
            {"name": "강남구청"}
          ]
        },
        {
          "type": 3,
          "time": 0,
          "startName": "강남구청",
          "endName": "강남구청",
          "distance": 0,
          "transports": null,
          "stations": null
        },
        {
          "type": 1,
          "time": 6,
          "startName": "강남구청",
          "endName": "논현",
          "distance": 1900,
          "transports": [
            {"subwayType": "7호선", "busNumber": null, "busType": null}
          ],
          "stations": [
            {"name": "강남구청"},
            {"name": "학동"},
            {"name": "논현"}
          ]
        },
        {
          "type": 3,
          "time": 3,
          "startName": "논현",
          "endName": "신사역",
          "distance": 198,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 18,
          "startName": "신사역",
          "endName": "이태원역.보광동입구",
          "distance": 4951,
          "transports": [
            {"subwayType": null, "busNumber": "421", "busType": "간선"}
          ],
          "stations": [
            {"name": "신사역"},
            {"name": "한남대교전망카페"},
            {"name": "순천향병원입구"},
            {"name": "한남역.용산노인종합복지관"},
            {"name": "한남동하이페리온"},
            {"name": "보광동신동아아파트"},
            {"name": "기업은행보광동지점"},
            {"name": "한국폴리텍1대학"},
            {"name": "이태원역.보광동입구"}
          ]
        },
        {
          "type": 3,
          "time": 1,
          "startName": "이태원역.보광동입구",
          "endName": "수서역",
          "distance": 88,
          "transports": null,
          "stations": null
        }
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
        {
          "type": 3,
          "time": 1,
          "startName": "멜로즈",
          "endName": "수서역현대벤쳐빌",
          "distance": 89,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 47,
          "startName": "수서역현대벤쳐빌",
          "endName": "순천향대학병원",
          "distance": 14383,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ],
          "stations": [
            {"name": "수서역현대벤쳐빌"},
            {"name": "수서역"},
            {"name": "일원주유소.삼성서울병원후문"},
            {"name": "삼성서울병원사거리"},
            {"name": "개포자이프레지던스"},
            {"name": "개포주공5단지경기여고"},
            {"name": "개포동역6번출구.개포시장"},
            {"name": "대치역6번출구.강남구민회관"},
            {"name": "은마아파트"},
            {"name": "은마파출소"},
            {"name": "대치현대아파트"},
            {"name": "대치사거리"},
            {"name": "포스코사거리"},
            {"name": "한별구립어린이집"},
            {"name": "센트럴아이파크.강남구도시관리공단"},
            {"name": "강남구청.강남세무서"},
            {"name": "청담동래미안아파트"},
            {"name": "강남구청역"},
            {"name": "영동고교앞"},
            {"name": "씨네시티앞"},
            {"name": "도산공원사거리"},
            {"name": "도산공원"},
            {"name": "신구중학교"},
            {"name": "현대아파트"},
            {"name": "광림교회.현대고등학교"},
            {"name": "신사중학교"},
            {"name": "한남대교전망카페"},
            {"name": "한남5거리"},
            {"name": "순천향대학병원"}
          ]
        },
        {
          "type": 3,
          "time": 0,
          "startName": "순천향대학병원",
          "endName": "순천향대학병원",
          "distance": 0,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 10,
          "startName": "순천향대학병원",
          "endName": "이태원119안전센터",
          "distance": 1765,
          "transports": [
            {"subwayType": null, "busNumber": "110A", "busType": "간선"},
            {"subwayType": null, "busNumber": "400", "busType": "간선"}
          ],
          "stations": [
            {"name": "순천향대학병원"},
            {"name": "한강진역.블루스퀘어"},
            {"name": "한남동주민센터"},
            {"name": "이태원119안전센터"}
          ]
        },
        {
          "type": 3,
          "time": 3,
          "startName": "이태원119안전센터",
          "endName": "수서역",
          "distance": 182,
          "transports": null,
          "stations": null
        }
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
        {
          "type": 3,
          "time": 3,
          "startName": "멜로즈",
          "endName": "수서역1번출구",
          "distance": 220,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 40,
          "startName": "수서역1번출구",
          "endName": "고속터미널",
          "distance": 11743,
          "transports": [
            {"subwayType": null, "busNumber": "361", "busType": "간선"}
          ],
          "stations": [
            {"name": "수서역1번출구"},
            {"name": "궁마을"},
            {"name": "태화기독교.사회복지관"},
            {"name": "수서삼성아파트앞"},
            {"name": "일원본동주민센터"},
            {"name": "푸른마을아파트앞"},
            {"name": "일원초등학교"},
            {"name": "대치아파트.대모산입구역3번출구"},
            {"name": "쌍용아파트"},
            {"name": "래미안하이스턴.대치순복음교회"},
            {"name": "은마아파트입구사거리"},
            {"name": "도곡초등학교"},
            {"name": "한티역2번출구.서울강남고용노동지청"},
            {"name": "한티역7번출구"},
            {"name": "역삼중학교.강남세브란스병원"},
            {"name": "역삼2동주민센터.대림역삼아파트"},
            {"name": "역삼자이아파트"},
            {"name": "KT강남지사"},
            {"name": "국민은행논현동지점"},
            {"name": "언주역4번출구.차병원사거리"},
            {"name": "삼정호텔"},
            {"name": "신논현역3번출구"},
            {"name": "논현역"},
            {"name": "논현역7번출구"},
            {"name": "반포역"},
            {"name": "고속터미널"}
          ]
        },
        {
          "type": 3,
          "time": 0,
          "startName": "고속터미널",
          "endName": "고속터미널",
          "distance": 0,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 13,
          "startName": "고속터미널",
          "endName": "용산구청",
          "distance": 3318,
          "transports": [
            {"subwayType": null, "busNumber": "143", "busType": "간선"}
          ],
          "stations": [
            {"name": "고속터미널"},
            {"name": "반포대교남단.한강시민공원입구"},
            {"name": "한강중학교"},
            {"name": "용산구청"}
          ]
        },
        {
          "type": 3,
          "time": 8,
          "startName": "용산구청",
          "endName": "수서역",
          "distance": 553,
          "transports": null,
          "stations": null
        }
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
        {
          "type": 3,
          "time": 3,
          "startName": "멜로즈",
          "endName": "수서역1번출구",
          "distance": 220,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 49,
          "startName": "수서역1번출구",
          "endName": "순천향대학병원",
          "distance": 15028,
          "transports": [
            {"subwayType": null, "busNumber": "402", "busType": "간선"}
          ],
          "stations": [
            {"name": "수서역1번출구"},
            {"name": "궁마을"},
            {"name": "태화기독교.사회복지관"},
            {"name": "수서삼성아파트앞"},
            {"name": "일원본동주민센터"},
            {"name": "푸른마을아파트앞"},
            {"name": "개포자이프레지던스"},
            {"name": "개포주공5단지경기여고"},
            {"name": "개포동역6번출구.개포시장"},
            {"name": "개포시장.개포5단지상가"},
            {"name": "개포6단지앞"},
            {"name": "대치아파트.대모산입구역3번출구"},
            {"name": "은마아파트"},
            {"name": "대치역1번출구"},
            {"name": "래미안대치팰리스"},
            {"name": "도곡역2번출구.동부센트레빌"},
            {"name": "숙명여고"},
            {"name": "매봉삼성아파트SK리더스뷰"},
            {"name": "매봉역양재최의원"},
            {"name": "양재역말죽거리.강남베드로병원"},
            {"name": "뱅뱅사거리"},
            {"name": "래미안아파트.파이낸셜뉴스"},
            {"name": "신분당선강남역"},
            {"name": "지하철2호선강남역"},
            {"name": "논현역"},
            {"name": "신사역"},
            {"name": "한남대교전망카페"},
            {"name": "한남5거리"},
            {"name": "순천향대학병원"}
          ]
        },
        {
          "type": 3,
          "time": 0,
          "startName": "순천향대학병원",
          "endName": "순천향대학병원",
          "distance": 0,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 10,
          "startName": "순천향대학병원",
          "endName": "이태원119안전센터",
          "distance": 1765,
          "transports": [
            {"subwayType": null, "busNumber": "110A", "busType": "간선"},
            {"subwayType": null, "busNumber": "400", "busType": "간선"}
          ],
          "stations": [
            {"name": "순천향대학병원"},
            {"name": "한강진역.블루스퀘어"},
            {"name": "한남동주민센터"},
            {"name": "이태원119안전센터"}
          ]
        },
        {
          "type": 3,
          "time": 3,
          "startName": "이태원119안전센터",
          "endName": "수서역",
          "distance": 182,
          "transports": null,
          "stations": null
        }
      ]
    },
    {
      "type": 2,
      "time": 60,
      "walkTime": 2,
      "payment": 1700,
      "busTransitCount": 2,
      "subwayTransitCount": 0,
      "subPaths": [
        {
          "type": 3,
          "time": 1,
          "startName": "멜로즈",
          "endName": "수서역현대벤쳐빌",
          "distance": 89,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 43,
          "startName": "수서역현대벤쳐빌",
          "endName": "한남대교전망카페",
          "distance": 12783,
          "transports": [
            {"subwayType": null, "busNumber": "3011", "busType": "지선"}
          ],
          "stations": [
            {"name": "수서역현대벤쳐빌"},
            {"name": "수서역"},
            {"name": "일원주유소.삼성서울병원후문"},
            {"name": "삼성서울병원사거리"},
            {"name": "개포자이프레지던스"},
            {"name": "개포주공5단지경기여고"},
            {"name": "개포동역6번출구.개포시장"},
            {"name": "대치역6번출구.강남구민회관"},
            {"name": "은마아파트"},
            {"name": "은마파출소"},
            {"name": "대치현대아파트"},
            {"name": "대치사거리"},
            {"name": "포스코사거리"},
            {"name": "한별구립어린이집"},
            {"name": "센트럴아이파크.강남구도시관리공단"},
            {"name": "강남구청.강남세무서"},
            {"name": "청담동래미안아파트"},
            {"name": "강남구청역"},
            {"name": "영동고교앞"},
            {"name": "씨네시티앞"},
            {"name": "도산공원사거리"},
            {"name": "도산공원"},
            {"name": "신구중학교"},
            {"name": "현대아파트"},
            {"name": "광림교회.현대고등학교"},
            {"name": "신사중학교"},
            {"name": "한남대교전망카페"}
          ]
        },
        {
          "type": 3,
          "time": 0,
          "startName": "한남대교전망카페",
          "endName": "한남대교전망카페",
          "distance": 0,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 15,
          "startName": "한남대교전망카페",
          "endName": "이태원역.보광동입구",
          "distance": 3578,
          "transports": [
            {"subwayType": null, "busNumber": "421", "busType": "간선"}
          ],
          "stations": [
            {"name": "한남대교전망카페"},
            {"name": "순천향병원입구"},
            {"name": "한남역.용산노인종합복지관"},
            {"name": "한남동하이페리온"},
            {"name": "보광동신동아아파트"},
            {"name": "기업은행보광동지점"},
            {"name": "한국폴리텍1대학"},
            {"name": "이태원역.보광동입구"}
          ]
        },
        {
          "type": 3,
          "time": 1,
          "startName": "이태원역.보광동입구",
          "endName": "수서역",
          "distance": 88,
          "transports": null,
          "stations": null
        }
      ]
    },
    {
      "type": 2,
      "time": 63,
      "walkTime": 8,
      "payment": 1700,
      "busTransitCount": 2,
      "subwayTransitCount": 0,
      "subPaths": [
        {
          "type": 3,
          "time": 3,
          "startName": "멜로즈",
          "endName": "수서역1번출구",
          "distance": 220,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 37,
          "startName": "수서역1번출구",
          "endName": "논현역7번출구",
          "distance": 10406,
          "transports": [
            {"subwayType": null, "busNumber": "361", "busType": "간선"}
          ],
          "stations": [
            {"name": "수서역1번출구"},
            {"name": "궁마을"},
            {"name": "태화기독교.사회복지관"},
            {"name": "수서삼성아파트앞"},
            {"name": "일원본동주민센터"},
            {"name": "푸른마을아파트앞"},
            {"name": "일원초등학교"},
            {"name": "대치아파트.대모산입구역3번출구"},
            {"name": "쌍용아파트"},
            {"name": "래미안하이스턴.대치순복음교회"},
            {"name": "은마아파트입구사거리"},
            {"name": "도곡초등학교"},
            {"name": "한티역2번출구.서울강남고용노동지청"},
            {"name": "한티역7번출구"},
            {"name": "역삼중학교.강남세브란스병원"},
            {"name": "역삼2동주민센터.대림역삼아파트"},
            {"name": "역삼자이아파트"},
            {"name": "KT강남지사"},
            {"name": "국민은행논현동지점"},
            {"name": "언주역4번출구.차병원사거리"},
            {"name": "삼정호텔"},
            {"name": "신논현역3번출구"},
            {"name": "논현역"},
            {"name": "논현역7번출구"}
          ]
        },
        {
          "type": 3,
          "time": 4,
          "startName": "논현역7번출구",
          "endName": "신사역",
          "distance": 271,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 18,
          "startName": "신사역",
          "endName": "이태원역.보광동입구",
          "distance": 4951,
          "transports": [
            {"subwayType": null, "busNumber": "421", "busType": "간선"}
          ],
          "stations": [
            {"name": "신사역"},
            {"name": "한남대교전망카페"},
            {"name": "순천향병원입구"},
            {"name": "한남역.용산노인종합복지관"},
            {"name": "한남동하이페리온"},
            {"name": "보광동신동아아파트"},
            {"name": "기업은행보광동지점"},
            {"name": "한국폴리텍1대학"},
            {"name": "이태원역.보광동입구"}
          ]
        },
        {
          "type": 3,
          "time": 1,
          "startName": "이태원역.보광동입구",
          "endName": "수서역",
          "distance": 88,
          "transports": null,
          "stations": null
        }
      ]
    },
    {
      "type": 2,
      "time": 64,
      "walkTime": 10,
      "payment": 1700,
      "busTransitCount": 2,
      "subwayTransitCount": 0,
      "subPaths": [
        {
          "type": 3,
          "time": 3,
          "startName": "멜로즈",
          "endName": "수서역1번출구",
          "distance": 220,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 37,
          "startName": "수서역1번출구",
          "endName": "논현역7번출구",
          "distance": 10406,
          "transports": [
            {"subwayType": null, "busNumber": "361", "busType": "간선"}
          ],
          "stations": [
            {"name": "수서역1번출구"},
            {"name": "궁마을"},
            {"name": "태화기독교.사회복지관"},
            {"name": "수서삼성아파트앞"},
            {"name": "일원본동주민센터"},
            {"name": "푸른마을아파트앞"},
            {"name": "일원초등학교"},
            {"name": "대치아파트.대모산입구역3번출구"},
            {"name": "쌍용아파트"},
            {"name": "래미안하이스턴.대치순복음교회"},
            {"name": "은마아파트입구사거리"},
            {"name": "도곡초등학교"},
            {"name": "한티역2번출구.서울강남고용노동지청"},
            {"name": "한티역7번출구"},
            {"name": "역삼중학교.강남세브란스병원"},
            {"name": "역삼2동주민센터.대림역삼아파트"},
            {"name": "역삼자이아파트"},
            {"name": "KT강남지사"},
            {"name": "국민은행논현동지점"},
            {"name": "언주역4번출구.차병원사거리"},
            {"name": "삼정호텔"},
            {"name": "신논현역3번출구"},
            {"name": "논현역"},
            {"name": "논현역7번출구"}
          ]
        },
        {
          "type": 3,
          "time": 4,
          "startName": "논현역7번출구",
          "endName": "신사역",
          "distance": 271,
          "transports": null,
          "stations": null
        },
        {
          "type": 2,
          "time": 17,
          "startName": "신사역",
          "endName": "이태원119안전센터",
          "distance": 4738,
          "transports": [
            {"subwayType": null, "busNumber": "400", "busType": "간선"}
          ],
          "stations": [
            {"name": "신사역"},
            {"name": "한남대교전망카페"},
            {"name": "한남5거리"},
            {"name": "순천향대학병원"},
            {"name": "한강진역.블루스퀘어"},
            {"name": "한남동주민센터"},
            {"name": "이태원119안전센터"}
          ]
        },
        {
          "type": 3,
          "time": 3,
          "startName": "이태원119안전센터",
          "endName": "수서역",
          "distance": 182,
          "transports": null,
          "stations": null
        }
      ]
    }
  ]
};
