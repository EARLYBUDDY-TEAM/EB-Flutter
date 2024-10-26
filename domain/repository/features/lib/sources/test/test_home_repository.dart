part of '../../eb_repository.dart';

final class TestHomeRepository implements HomeRepositoryAB {
  final List<Schedule> scheduleList;

  TestHomeRepository({
    required this.scheduleList,
  });

  @override
  Future<Result> getAllSchedules({required String accessToken}) async {
    final successResponse =
        SuccessResponse(statusCode: 200, model: scheduleList);
    return Success(success: successResponse);
  }

  @override
  Future<Result> deleteScheduleCard(
      {required String accessToken, required String scheduleID}) async {
    final successResponse = SuccessResponse(statusCode: 200, model: EmptyDTO());
    return Success(success: successResponse);
  }
}
