part of '../domain_model.dart';

final class EBPath extends Equatable {
  final String pathType;
  final EBPathInfo ebPathInfo;

  const EBPath({
    required this.pathType,
    required this.ebPathInfo,
  });

  EBPath.fromDTO({required EBPathDTO ebPathDTO})
      : pathType = _pathType(ebPathDTO.pathType),
        ebPathInfo = EBPathInfo.fromDTO(ebPathInfoDTO: ebPathDTO.ebPathInfo);

  @override
  List<Object?> get props => [pathType, ebPathInfo];

  static EBPath mock() {
    return EBPath(
      pathType: _pathType(3),
      ebPathInfo: EBPathInfo.mock(),
    );
  }
}

String _pathType(int pathType) {
  if (pathType == 1) {
    return '지하철';
  } else if (pathType == 2) {
    return '버스';
  } else {
    return '지하철 + 버스';
  }
}
