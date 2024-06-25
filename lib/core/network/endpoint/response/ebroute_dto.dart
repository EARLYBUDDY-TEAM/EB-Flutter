import 'dart:developer';

// final class EBRouteResultDTO {
//   final EBRouteDTO ebRouteDTO;

//   EBRouteResultDTO({required this.ebRouteDTO});

//   static EBRouteResultDTO fromJson(Map<String, dynamic> j) {
//     final ebRouteDTO = EBRouteDTO.fromJson(j['result']);
//     return EBRouteResultDTO(ebRouteDTO: ebRouteDTO);
//   }
// }

final class EBRouteDTO {
  final int searchType;
  final List<EBPathDTO> ebPaths;

  EBRouteDTO({
    required this.searchType,
    required this.ebPaths,
  });

  static EBRouteDTO fromJson(Map<String, dynamic> j) {
    final ebPathList = j['path'] as List;
    final ebPaths = ebPathList.map((p) => EBPathDTO.fromJson(p)).toList();
    return EBRouteDTO(searchType: j['searchType'], ebPaths: ebPaths);
  }
}

final class EBPathDTO {
  final int pathType;
  final EBPathInfoDTO ebPathInfo;

  EBPathDTO({
    required this.pathType,
    required this.ebPathInfo,
  });

  static EBPathDTO fromJson(Map<String, dynamic> j) {
    final ebPathInfo = EBPathInfoDTO.fromJson(j['info']);
    return EBPathDTO(
      pathType: j['pathType'],
      ebPathInfo: ebPathInfo,
    );
  }
}

final class EBPathInfoDTO {
  final int totalTime;
  final int payment;
  final int busTransitCount;
  final int subwayTransitCount;

  EBPathInfoDTO({
    required this.totalTime,
    required this.payment,
    required this.busTransitCount,
    required this.subwayTransitCount,
  });

  static EBPathInfoDTO fromJson(Map<String, dynamic> j) {
    return EBPathInfoDTO(
      totalTime: j['totalTime'],
      payment: j['payment'],
      busTransitCount: j['busTransitCount'],
      subwayTransitCount: j['subwayTransitCount'],
    );
  }
}
