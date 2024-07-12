part of '../domain_model.dart';

final class EBRoute extends Equatable {
  final int type;
  final List<EBPath> ebPaths;

  const EBRoute({
    required this.type,
    required this.ebPaths,
  });

  EBRoute.fromDTO({required EBRouteDTO ebRouteDTO})
      : type = ebRouteDTO.type,
        ebPaths = ebRouteDTO.ebPaths
            .map((p) => EBPath.fromDTO(ebPathDTO: p))
            .toList();

  @override
  List<Object?> get props => [type, ebPaths];

  static EBRoute mock() {
    return EBRoute.fromDTO(ebRouteDTO: EBRouteDTO.mock());
  }
}
