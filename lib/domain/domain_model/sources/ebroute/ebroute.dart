part of '../domain_model.dart';

final class EBRoute extends Equatable {
  final int searchType;
  final List<EBPath> ebPaths;

  const EBRoute({
    required this.searchType,
    required this.ebPaths,
  });

  EBRoute.fromDTO({required EBRouteDTO ebRouteDTO})
      : searchType = ebRouteDTO.searchType,
        ebPaths = ebRouteDTO.ebPaths
            .map((p) => EBPath.fromDTO(ebPathDTO: p))
            .toList();

  @override
  List<Object?> get props => [searchType, ebPaths];
}
