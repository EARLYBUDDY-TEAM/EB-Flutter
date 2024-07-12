import 'package:earlybuddy/core/network/endpoint/endpoint.dart';
import 'package:earlybuddy/core/network/network_service/network_service.dart';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';

final class FindRouteRepository {
  final NetworkService service;

  FindRouteRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService.shared;

  Future<EBRoute> getEBRoute() async {
    final request = FindRouteRequest.init();
    final EBRouteDTO ebRouteDTO = await service.request(request);
    final ebRoute = EBRoute.fromDTO(ebRouteDTO: ebRouteDTO);
    return ebRoute;
  }
}
