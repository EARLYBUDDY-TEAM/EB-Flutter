import 'package:earlybuddy/domain/network/endpoint/endpoint.dart';
import 'package:earlybuddy/domain/network/network_service/network_service.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';

final class FindRouteRepository {
  final NetworkService service;

  FindRouteRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService.shared;

  Future<EBRoute> getEBRoute({
    required Coordi start,
    required Coordi end,
  }) async {
    final request = FindRouteRequest.init(
      sx: start.x,
      sy: start.y,
      ex: end.x,
      ey: end.y,
    );
    final EBRouteDTO ebRouteDTO = await service.request(request);
    final ebRoute = EBRoute.fromDTO(ebRouteDTO: ebRouteDTO);
    return ebRoute;
  }
}
