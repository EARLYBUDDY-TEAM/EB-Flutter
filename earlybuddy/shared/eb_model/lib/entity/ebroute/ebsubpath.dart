part of '../../entity.dart';

final class EBSubPath extends Equatable {
  final int type;
  final int time;
  final String startName;
  final String endName;
  final int distance;
  final List<Transport> transports;
  final List<Station> stations;

  const EBSubPath({
    required this.type,
    required this.time,
    required this.startName,
    required this.endName,
    required this.distance,
    required this.transports,
    required this.stations,
  });

  EBSubPath copyWith({
    int? type,
    int? time,
    String? startName,
    String? endName,
    int? distance,
    List<Transport>? transports,
    List<Station>? stations,
  }) {
    return EBSubPath(
      type: type ?? this.type,
      time: time ?? this.time,
      startName: startName ?? this.startName,
      endName: endName ?? this.endName,
      distance: distance ?? this.distance,
      transports: transports ?? this.transports,
      stations: stations ?? this.stations,
    );
  }

  @override
  List<Object?> get props => [
        type,
        time,
        startName,
        endName,
        distance,
        transports,
        stations,
      ];

  static EBSubPath fromDTO({required EBSubPathDTO ebSubPathDTO}) {
    var transports = [Transport.walk()];
    if (ebSubPathDTO.transports != null) {
      transports = ebSubPathDTO.transports!
          .map((dto) => Transport.fromDTO(transportDTO: dto))
          .toList();
    }
    List<Station> stations = [];
    if (ebSubPathDTO.stations != null) {
      stations = ebSubPathDTO.stations!
          .map((dto) => Station.fromDTO(stationDTO: dto))
          .toList();
    }

    return EBSubPath(
      type: ebSubPathDTO.type,
      time: ebSubPathDTO.time,
      startName: ebSubPathDTO.startName,
      endName: ebSubPathDTO.endName,
      distance: ebSubPathDTO.distance,
      transports: transports,
      stations: stations,
    );
  }

  static EBSubPath mockWalk() {
    return EBSubPath(
      type: 3,
      time: 3,
      startName: '수서역',
      endName: '스타벅스 수서역 R점',
      distance: 365,
      transports: [Transport.walk()],
      stations: const [],
    );
  }

  static EBSubPath mockSubway() {
    return EBSubPath(
      type: 1,
      time: 32,
      startName: '수서역',
      endName: '이태원',
      distance: 13929,
      transports: [Transport.mockSubway()],
      stations: const [
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
      endName: '이태원',
      distance: 13929,
      transports: [Transport.mockBus()],
      stations: const [
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
        Station(name: '수서역'),
      ],
    );
  }
}
