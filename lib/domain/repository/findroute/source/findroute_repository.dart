import 'package:earlybuddy/core/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/core/network/sources/service/service.dart';
import 'package:earlybuddy/shared/eb_model/entity/entity.dart';

final class FindRouteRepository {
  final NetworkService service;

  FindRouteRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService.shared;

  Future<EBRoute> getEBRoute({
    required Place start,
    required Place end,
  }) async {
    final request = FindRouteRequest.init(
      sx: start.coordi.x,
      sy: start.coordi.y,
      ex: end.coordi.x,
      ey: end.coordi.y,
      startPlace: start.name,
      endPlace: end.name,
    );

    final result = await service.request(request);
    EBRouteDTO ebRouteDTO;
    switch (result) {
      case (Success()):
        ebRouteDTO = result.model;
      case (Failure()):
        throw 'error';
    }

    final ebRoute = EBRoute.fromDTO(ebRouteDTO: ebRouteDTO);
    return ebRoute;
  }
}
