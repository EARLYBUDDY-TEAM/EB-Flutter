part of '../../eb_repository.dart';

final class FindRouteRepository {
  final NetworkService service;

  FindRouteRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService.shared;

  Future<Result> getEBRoute({
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

    switch (result) {
      case (Success()):
        final EBRouteDTO dto = result.success.model;
        final EBRoute ebRoute = EBRoute.fromDTO(ebRouteDTO: dto);
        return Success(
          success: SuccessResponse(
            model: ebRoute,
            statusCode: result.success.statusCode,
          ),
        );
      case (Failure()):
        final FailureResponse failureResponse = result.failure;
        log(failureResponse.error.toString());
        log(failureResponse.statusCode.toString());
        return result;
    }
  }
}
