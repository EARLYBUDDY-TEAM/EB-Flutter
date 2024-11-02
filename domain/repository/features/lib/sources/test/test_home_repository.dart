part of '../../eb_repository.dart';

final class TestHomeRepository implements HomeRepositoryAB {
  final List<SchedulePath> schedulePathList;

  TestHomeRepository({
    required this.schedulePathList,
  });

  @override
  Future<Result> getAllSchedules({required String accessToken}) async {
    final successResponse =
        SuccessResponse(statusCode: 200, model: schedulePathList);
    return Success(success: successResponse);
  }

  @override
  Future<Result> getBusRealTimeInfo({required int stationID}) async {
    final mockRealTimeInfo = await delayMockRealTimeInfo();
    final successResponse =
        SuccessResponse(statusCode: 200, model: mockRealTimeInfo);
    return Success(success: successResponse);
  }

  @override
  Future<Result> getSubwayRealTimeInfo({required int stationID}) async {
    final mockRealTimeInfo = await delayMockRealTimeInfo();
    final successResponse =
        SuccessResponse(statusCode: 200, model: mockRealTimeInfo);
    return Success(success: successResponse);
  }

  Future<RealTimeInfo> delayMockRealTimeInfo() async {
    final random = math.Random();
    const double minSec = 0.5;
    const double maxSec = 2.0;
    final tmpDelaySec = random.nextDouble() * (maxSec - minSec) + minSec;
    final delayMilliSecond = (tmpDelaySec * 1000).round();

    await Future.delayed(Duration(milliseconds: delayMilliSecond));

    return RealTimeInfo.mock();
  }
}
