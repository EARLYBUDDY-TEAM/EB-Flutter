part of '../../eb_repository.dart';

final class TestHomeRepository implements HomeRepositoryAB {
  final List<SchedulePath> schedulePathList;
  final List<String> transportNameList;

  TestHomeRepository({
    required this.schedulePathList,
    required this.transportNameList,
  });

  @override
  Future<Result> getAllSchedules({required String accessToken}) async {
    final successResponse =
        SuccessResponse(statusCode: 200, model: schedulePathList);
    return Success(success: successResponse);
  }

  @override
  Future<Result> getBusRealTimeInfo({required int stationID}) async {
    final mockRealTimeInfo = await delayMockRealTimeInfoList();
    final successResponse =
        SuccessResponse(statusCode: 200, model: mockRealTimeInfo);
    return Success(success: successResponse);
  }

  @override
  Future<Result> getTotalSubwaySchedule({
    required int stationID,
    required int wayCode,
  }) async {
    final mockRealTimeInfo = await delayMockRealTimeInfoList();
    final successResponse = SuccessResponse(
      statusCode: 200,
      model: mockRealTimeInfo,
    );
    return Success(success: successResponse);
  }

  Future<List<RealTimeInfo>> delayMockRealTimeInfoList() async {
    final random = math.Random();
    const double minSec = 0.5;
    const double maxSec = 2.0;
    final tmpDelaySec = random.nextDouble() * (maxSec - minSec) + minSec;
    final delayMilliSecond = (tmpDelaySec * 1000).round();

    await Future.delayed(Duration(milliseconds: delayMilliSecond));

    return transportNameList.map<RealTimeInfo>(
      (e) {
        return RealTimeInfo.mock(transportName: e);
      },
    ).toList();
  }
}
