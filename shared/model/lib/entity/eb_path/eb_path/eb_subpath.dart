part of '../../../entity.dart';

final class EBSubPath extends Equatable {
  final int type;
  final int time;
  final String startName;
  final Coordi? startCoordi;
  final int? startStationID;
  final String endName;
  final int distance;
  final TransportList transportList;
  final List<Station> stationList;

  const EBSubPath({
    required this.type,
    required this.time,
    required this.startName,
    required this.startCoordi,
    required this.startStationID,
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
    String? endName,
    int? distance,
    TransportList? transportList,
    List<Station>? stationList,
  }) {
    return EBSubPath(
      type: type ?? this.type,
      time: time ?? this.time,
      startName: startName ?? this.startName,
      startCoordi: startCoordi != null ? startCoordi() : this.startCoordi,
      startStationID:
          startStationID != null ? startStationID() : this.startStationID,
      endName: endName ?? this.endName,
      distance: distance ?? this.distance,
      transportList: transportList ?? this.transportList,
      stationList: stationList ?? this.stationList,
    );
  }

  EBSubPathDTO toDTO() {
    List<TransportDTO> transports;
    final tmpTransportList = transportList;
    switch (tmpTransportList) {
      case BusList():
        transports = tmpTransportList.toDTO();
      case SubwayList():
        transports = tmpTransportList.toDTO();
      case EmptyTransportList():
        transports = [];
    }

    final stations = stationList.map((s) => s.toDTO()).toList();

    return EBSubPathDTO(
      type: type,
      time: time,
      startName: startName,
      startX: startCoordi?.x,
      startY: startCoordi?.y,
      startStationID: startStationID,
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
    TransportList tmpTransportList = EmptyTransportList();
    final transports = ebSubPathDTO.transports;
    if (transports != null) {
      final transportType = ebSubPathDTO.type;
      switch (transportType) {
        case (1):
          final subwayList = transports
              .map(
                (dto) => Subway.fromDTO(transportDTO: dto),
              )
              .toList();
          tmpTransportList = SubwayList(subwayList: subwayList);
        case (2):
          final busList = transports
              .map(
                (dto) => Bus.fromDTO(transportDTO: dto),
              )
              .toList();

          tmpTransportList = BusList(busList: busList);
        default:
          tmpTransportList = EmptyTransportList();
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
      endName: ebSubPathDTO.endName,
      distance: ebSubPathDTO.distance,
      transportList: tmpTransportList,
      stationList: stationList,
    );
  }

  static EBSubPath mockWalk() {
    return EBSubPath(
      type: 3,
      time: 3,
      startName: '수서역',
      startCoordi: null,
      startStationID: null,
      endName: '스타벅스 수서역 R점',
      distance: 365,
      transportList: EmptyTransportList(),
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
      endName: '이태원',
      distance: 13929,
      transportList: TransportList.mockSubwayList(),
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
      endName: '이태원',
      distance: 13929,
      transportList: TransportList.mockBusList(),
      stationList: const [
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
      ],
    );
  }
}
