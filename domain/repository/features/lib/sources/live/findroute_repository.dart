part of '../../eb_repository.dart';

final class FindRouteRepository {
  final NetworkService _networkService;

  FindRouteRepository({
    NetworkService? networkService,
  }) : _networkService = networkService ?? NetworkService.shared;

  Future<NetworkResponse<EBRoute>> getEBRoute({
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

    final result = await _networkService.request(request);

    switch (result) {
      case (SuccessResponse()):
        final EBRoute ebRoute = EBRoute.fromDTO(ebRouteDTO: result.model);
        return result.copyWith<EBRoute>(model: ebRoute);
      case (FailureResponse()):
        log(result.error.toString());
        log(result.statusCode.toString());
        return result.copyWith<EBRoute>();
    }
  }
}
