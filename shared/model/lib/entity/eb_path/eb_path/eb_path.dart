part of '../../../entity.dart';

final class EBPath extends Equatable {
  final int type;
  final int time;
  final int walkTime;
  final int payment;
  final int busTransitCount;
  final int subwayTransitCount;
  final List<EBSubPath> ebSubPathList;

  const EBPath({
    required this.type,
    required this.time,
    required this.walkTime,
    required this.payment,
    required this.busTransitCount,
    required this.subwayTransitCount,
    required this.ebSubPathList,
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

  EBPath copyWith({
    int? type,
    int? time,
    int? walkTime,
    int? payment,
    int? busTransitCount,
    int? subwayTransitCount,
    List<EBSubPath>? ebSubPathList,
  }) {
    return EBPath(
      type: type ?? this.type,
      time: time ?? this.time,
      walkTime: walkTime ?? this.walkTime,
      payment: payment ?? this.payment,
      busTransitCount: busTransitCount ?? this.busTransitCount,
      subwayTransitCount: subwayTransitCount ?? this.subwayTransitCount,
      ebSubPathList: ebSubPathList ?? this.ebSubPathList,
    );
  }

  EBPathDTO toDTO() {
    final ebSubPaths = ebSubPathList.map((s) => s.toDTO()).toList();

    return EBPathDTO(
      type: type,
      time: time,
      walkTime: walkTime,
      payment: payment,
      busTransitCount: busTransitCount,
      subwayTransitCount: subwayTransitCount,
      ebSubPaths: ebSubPaths,
    );
  }

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
      ebSubPathList: ebSubPaths,
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
        ebSubPathList,
      ];

  static EBPath mock() {
    return EBPath(
      type: 3,
      time: 92,
      walkTime: 12,
      payment: 3400,
      busTransitCount: 4,
      subwayTransitCount: 3,
      ebSubPathList: [
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

  static EBPath mockGasanToSuwon() {
    final dto = EBPathDTO.mockGasanToSuwon();
    return EBPath.fromDTO(ebPathDTO: dto);
  }
}
