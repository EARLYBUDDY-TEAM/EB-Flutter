part of '../../../entity.dart';

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

  static EBSubPath modifyWalkSubPath({
    required EBSubPath curSubPath,
    required String startName,
    required String endName,
  }) {
    return curSubPath.copyWith(
      startName: startName,
      endName: endName,
    );
  }

  Map<String, dynamic> toMap() {
    final subPathsMap = ebSubPaths.map((s) => s.toMap()).toList();

    return {
      "type": type,
      "time": time,
      "walkTime": walkTime,
      "payment": payment,
      "busTransitCount": busTransitCount,
      "subwayTransitCount": subwayTransitCount,
      "subPaths": subPathsMap,
    };
  }

  // 서버에서 작업하기
  static EBPath fromDTO({required EBPathDTO ebPathDTO}) {
    List<EBSubPath> ebSubPaths = ebPathDTO.ebSubPaths
        .map((s) => EBSubPath.fromDTO(ebSubPathDTO: s))
        .toList();

    return EBPath(
      type: ebPathDTO.type,
      time: ebPathDTO.time,
      walkTime: ebPathDTO.walkTime,
      payment: ebPathDTO.payment,
      busTransitCount: ebPathDTO.busTransitCount,
      subwayTransitCount: ebPathDTO.subwayTransitCount,
      ebSubPaths: ebSubPaths,
    );
  }

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

  static EBPath mockDongToGwang() {
    final dto = EBPathDTO.mockDongToGwang();
    return EBPath.fromDTO(ebPathDTO: dto);
  }
}
