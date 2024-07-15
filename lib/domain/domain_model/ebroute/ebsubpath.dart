part of '../domain_model.dart';

final class EBSubPath extends Equatable {
  final int type;
  final int time;
  final List<Transport> transports;

  const EBSubPath({
    required this.type,
    required this.time,
    required this.transports,
  });

  @override
  List<Object?> get props => [type, time, transports];

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
      transports: transports,
    );
  }

  static EBSubPath mockWalk() {
    return EBSubPath(
      type: 3,
      time: 3,
      transports: [Transport.walk()],
    );
  }

  static EBSubPath mockSubway() {
    return EBSubPath(
      type: 3,
      time: 32,
      transports: [Transport.mockSubway()],
    );
  }

  static EBSubPath mockBus() {
    return EBSubPath(
      type: 2,
      time: 48,
      transports: [Transport.mockBus()],
    );
  }
}
