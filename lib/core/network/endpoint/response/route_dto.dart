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
  final List<EBPathInfoDTO> ebPathInfos;

  EBPathDTO({
    required this.pathType,
    required this.ebPathInfos,
  });

  static EBPathDTO fromJson(Map<String, dynamic> j) {
    final ebPathInfoList = j['info'] as List;
    final ebPathInfos =
        ebPathInfoList.map((i) => EBPathInfoDTO.fromJson(i)).toList();
    return EBPathDTO(pathType: j['pathType'], ebPathInfos: ebPathInfos);
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
