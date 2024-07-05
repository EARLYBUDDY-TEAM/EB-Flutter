part of '../domain_model.dart';

final class EBPath extends Equatable {
  final int type;
  final int time;
  final int walkTime;
  final int payment;
  final int busTransitCount;
  final int subwayTransitCount;
  final List<EBSubPath> ebSubPaths;

  const EBPath({
    required this.type,
    required this.time,
    required this.walkTime,
    required this.payment,
    required this.busTransitCount,
    required this.subwayTransitCount,
    required this.ebSubPaths,
  });

  EBPath.fromDTO({required EBPathDTO ebPathDTO})
      : type = ebPathDTO.type,
        time = ebPathDTO.time,
        walkTime = ebPathDTO.walkTime,
        payment = ebPathDTO.payment,
        busTransitCount = ebPathDTO.busTransitCount,
        subwayTransitCount = ebPathDTO.subwayTransitCount,
        ebSubPaths = ebPathDTO.ebSubPaths
            .map((s) => EBSubPath.fromDTO(ebSubPathDTO: s))
            .toList();

  @override
  List<Object?> get props => [
        type,
        time,
        walkTime,
        payment,
        busTransitCount,
        subwayTransitCount,
        ebSubPaths,
      ];

  static EBPath mock() {
    return EBPath(
      type: 3,
      time: 92,
      walkTime: 12,
      payment: 3400,
      busTransitCount: 4,
      subwayTransitCount: 3,
      ebSubPaths: [
        EBSubPath.mockBus(),
        EBSubPath.mockWalk(),
        EBSubPath.mockSubway(),
        EBSubPath.mockWalk(),
      ],
    );
  }
}
