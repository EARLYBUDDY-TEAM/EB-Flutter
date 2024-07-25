import 'package:earlybuddy/domain/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/domain/network/sources/service/service.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';

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
        ebRouteDTO = result.dto;
      case (Failure()):
        throw 'error';
    }

    final ebRoute = EBRoute.fromDTO(ebRouteDTO: ebRouteDTO);
    return ebRoute;
  }
}
