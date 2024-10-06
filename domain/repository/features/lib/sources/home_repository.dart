part of '../eb_repository.dart';

final class HomeRepository {
  final NetworkService service;

  HomeRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService();

  Future<Result> getAllScheduleCards({
    required String accessToken,
  }) async {
    final request = HomeRequest.getAllScheduleCards(
      accessToken: accessToken,
    );
    final result = await service.request(request);

    switch (result) {
      case (Success()):
        final SuccessResponse successResponse = result.success;
        final ScheduleCardListDTO scheduleCardListDTO = successResponse.model;
        final List<ScheduleCard> scheduleCardList =
            scheduleCardListDTO.scheduleCardList
                .map(
                  (dto) => ScheduleCard.fromDTO(scheduleCardDTO: dto),
                )
                .toList();
        final newSuccessResponse = SuccessResponse(
          statusCode: successResponse.statusCode,
          model: scheduleCardList,
        );
        final newResult = Success(success: newSuccessResponse);
        return newResult;
      case (Failure()):
        final FailureResponse failureResponse = result.failure;
        log(failureResponse.error.toString());
        log(failureResponse.statusCode.toString());
        return result;
    }
  }

  Future<Result> deleteScheduleCard({
    required String accessToken,
    required int scheduleID,
  }) async {
    final request = HomeRequest.deleteScheduleCard(
      accessToken: accessToken,
      scheduleID: scheduleID,
    );

    final result = await service.request(request);

    switch (result) {
      case (Success()):
        return result;
      case (Failure()):
        final FailureResponse failureResponse = result.failure;
        log(failureResponse.error.toString());
        log(failureResponse.statusCode.toString());
        return result;
    }
  }
}
