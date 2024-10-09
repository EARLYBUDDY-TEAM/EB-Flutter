part of '../../eb_repository.dart';

final class TestHomeRepository implements HomeRepositoryAB {
  final List<ScheduleCard> scheduleCardList;

  TestHomeRepository({
    required this.scheduleCardList,
  });

  @override
  Future<Result> getAllScheduleCards({required String accessToken}) async {
    final successResponse =
        SuccessResponse(statusCode: 200, model: scheduleCardList);
    return Success(success: successResponse);
  }

  @override
  Future<Result> deleteScheduleCard(
      {required String accessToken, required int scheduleID}) async {
    final successResponse = SuccessResponse(statusCode: 200, model: EmptyDTO());
    return Success(success: successResponse);
  }
}
