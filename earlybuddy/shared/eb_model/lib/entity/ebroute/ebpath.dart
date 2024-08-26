part of '../../entity.dart';

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

  // 서버에서 작업하기
  static EBPath fromDTO({required EBPathDTO ebPathDTO}) {
    List<EBSubPath> ebSubPaths = ebPathDTO.ebSubPaths
        .map((s) => EBSubPath.fromDTO(ebSubPathDTO: s))
        .toList();

    // if (ebSubPaths.length == 1 && ebSubPaths[0].type == 3) {
    //   ebSubPaths = [
    //     modifyWalkSubPath(
    //       curSubPath: ebSubPaths[0],
    //       startName: startPlace,
    //       endName: endPlace,
    //     ),
    //   ];
    // } else if (2 <= ebSubPaths.length) {
    //   ebSubPaths = ebSubPaths.asMap().entries.map((s) {
    //     int index = s.key;
    //     EBSubPath curSubPath = s.value;

    //     if (curSubPath.type != 3) {
    //       return curSubPath;
    //     }

    //     if (index == 0) {
    //       String endName = ebSubPaths[index + 1].startName;
    //       return modifyWalkSubPath(
    //         curSubPath: curSubPath,
    //         startName: startPlace,
    //         endName: endName,
    //       );
    //     } else if (index == ebSubPaths.length - 1) {
    //       String startName = ebSubPaths[index - 1].endName;
    //       return modifyWalkSubPath(
    //         curSubPath: curSubPath,
    //         startName: startName,
    //         endName: endPlace,
    //       );
    //     } else {
    //       String startName = ebSubPaths[index - 1].endName;
    //       String endName = ebSubPaths[index + 1].startName;
    //       return modifyWalkSubPath(
    //         curSubPath: curSubPath,
    //         startName: startName,
    //         endName: endName,
    //       );
    //     }
    //   }).toList();
    // }

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
}
