import 'package:earlybuddy/domain/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/domain/network/sources/network_service/network_service.dart';
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
    final EBRouteDTO ebRouteDTO = await service.request(request);
    final ebRoute = EBRoute.fromDTO(ebRouteDTO: ebRouteDTO);
    return ebRoute;
  }
}
