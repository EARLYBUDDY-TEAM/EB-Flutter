part of '../../entity.dart';

final class EBRoute extends Equatable {
  final int type;
  final List<EBPath> ebPaths;

  const EBRoute({
    this.type = 1,
    this.ebPaths = const [],
  });

  EBRoute.fromDTO({
    required EBRouteDTO ebRouteDTO,
  })  : type = ebRouteDTO.type,
        ebPaths = ebRouteDTO.ebPaths
            .map((p) => EBPath.fromDTO(ebPathDTO: p))
            .toList();

  @override
  List<Object?> get props => [type, ebPaths];

  static EBRoute mock() {
    return EBRoute.fromDTO(ebRouteDTO: EBRouteDTO.mock());
  }
}
