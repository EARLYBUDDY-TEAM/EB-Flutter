part of '../domain_model.dart';

final class EBSubPath extends Equatable {
  final int type;
  final int time;
  final String startName;
  final String endName;
  final int distance;
  final List<Transport> transports;

  const EBSubPath({
    required this.type,
    required this.time,
    required this.startName,
    required this.endName,
    required this.distance,
    required this.transports,
  });

  @override
  List<Object?> get props => [
        type,
        time,
        startName,
        endName,
        distance,
        transports,
      ];

  static EBSubPath fromDTO({required EBSubPathDTO ebSubPathDTO}) {
    var transports = [Transport.walk()];
    if (ebSubPathDTO.transports != null) {
      transports = ebSubPathDTO.transports!
          .map((dto) => Transport.fromDTO(transportDTO: dto))
          .toList();
    }
    return EBSubPath(
      type: ebSubPathDTO.type,
      time: ebSubPathDTO.time,
      startName: ebSubPathDTO.startName,
      endName: ebSubPathDTO.endName,
      distance: ebSubPathDTO.distance,
      transports: transports,
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
    );
  }
}
