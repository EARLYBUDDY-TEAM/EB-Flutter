part of '../../entity.dart';

final class EBSubPath<T extends Transport> extends Equatable {
  final int type;
  final int time;
  final String startName;
  final Coordi? startCoordi;
  final int? startStationID;
  final int? wayCode;
  final String endName;
  final int distance;
  final List<T> transportList;
  final List<Station> stationList;

  const EBSubPath({
    required this.type,
    required this.time,
    required this.startName,
    required this.startCoordi,
    required this.startStationID,
    required this.wayCode,
    required this.endName,
    required this.distance,
    required this.transportList,
    required this.stationList,
  });

  EBSubPath copyWith({
    int? type,
    int? time,
    String? startName,
    Coordi? Function()? startCoordi,
    int? Function()? startStationID,
    int? Function()? wayCode,
    String? endName,
    int? distance,
    List<T>? transportList,
    List<Station>? stationList,
    DateTime? expectStartTime,
    int? expectTotalTime,
  }) {
    return EBSubPath(
      type: type ?? this.type,
      time: time ?? this.time,
      startName: startName ?? this.startName,
      startCoordi: startCoordi != null ? startCoordi() : this.startCoordi,
      startStationID:
          startStationID != null ? startStationID() : this.startStationID,
      wayCode: wayCode != null ? wayCode() : this.wayCode,
      endName: endName ?? this.endName,
      distance: distance ?? this.distance,
      transportList: transportList ?? this.transportList,
      stationList: stationList ?? this.stationList,
    );
  }

  EBSubPathDTO toDTO() {
    final transports =
        transportList.map<TransportDTO>((t) => t.toDTO()).toList();

    final stations = stationList.map((s) => s.toDTO()).toList();

    return EBSubPathDTO(
      type: type,
      time: time,
      startName: startName,
      startX: startCoordi?.x,
      startY: startCoordi?.y,
      startStationID: startStationID,
      wayCode: wayCode,
      endName: endName,
      distance: distance,
      transports: transports,
      stations: stations,
    );
  }

  @override
  List<Object?> get props => [
        type,
        time,
        startName,
        startCoordi,
        startStationID,
        endName,
        distance,
        transportList,
        stationList,
      ];

  static EBSubPath fromDTO({
    required EBSubPathDTO ebSubPathDTO,
  }) {
    final transports = ebSubPathDTO.transports;
    List<Transport> transportList = [];
    if (transports != null) {
      final transportType = ebSubPathDTO.type;
      switch (transportType) {
        case (1):
          transportList = transports
              .map<Subway>((t) => Subway.fromDTO(transportDTO: t))
              .toList();
        case (2):
          transportList =
              transports.map<Bus>((t) => Bus.fromDTO(transportDTO: t)).toList();
        default:
          break;
      }
    }

    List<Station> stationList = [];
    if (ebSubPathDTO.stations != null) {
      stationList = ebSubPathDTO.stations!
          .map((dto) => Station.fromDTO(stationDTO: dto))
          .toList();
    }

    Coordi? startCoordi;
    if ((ebSubPathDTO.startX != null) && (ebSubPathDTO.startY != null)) {
      startCoordi = Coordi(
        x: ebSubPathDTO.startX!,
        y: ebSubPathDTO.startY!,
      );
    }

    return EBSubPath(
      type: ebSubPathDTO.type,
      time: ebSubPathDTO.time,
      startName: ebSubPathDTO.startName,
      startCoordi: startCoordi,
      startStationID: ebSubPathDTO.startStationID,
      wayCode: ebSubPathDTO.wayCode,
      endName: ebSubPathDTO.endName,
      distance: ebSubPathDTO.distance,
      transportList: transportList,
      stationList: stationList,
    );
  }

  static EBSubPath mockWalk() {
    final testStartName = '수서역' * 10;
    final testEndName = '스타벅스 수서역 R점' * 10;

    return EBSubPath(
      type: 3,
      time: 3,
      startName: testStartName,
      startCoordi: null,
      startStationID: null,
      wayCode: null,
      endName: testEndName,
      distance: 365,
      transportList: const [],
      stationList: const [],
    );
  }

  static EBSubPath mockSubway() {
    return EBSubPath(
      type: 1,
      time: 32,
      startName: '수서역',
      startCoordi: Coordi.mockStart(),
      startStationID: 536,
      wayCode: 1,
      endName: '이태원',
      distance: 13929,
      transportList: [
        Subway.mock(),
      ],
      stationList: const [
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
      ],
    );
  }

  static EBSubPath mockBus() {
    return EBSubPath(
      type: 2,
      time: 48,
      startName: '수서역',
      startCoordi: Coordi.mockStart(),
      startStationID: 80606,
      wayCode: null,
      endName: '이태원',
      distance: 13929,
      transportList: [
        Bus.mock(),
        Bus.mock(),
        Bus.mock(),
      ],
      stationList: const [
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
      ],
    );
  }

  static EBSubPath mockDongToGwang() {
    final dto = EBSubPathDTO.mockDongToGwang();
    return EBSubPath.fromDTO(ebSubPathDTO: dto);
  }

  static EBSubPath mockGasanToSuwon() {
    final dto = EBSubPathDTO.mockGasanToSuwon();
    return EBSubPath.fromDTO(ebSubPathDTO: dto);
  }
}
