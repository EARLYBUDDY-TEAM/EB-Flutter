part of '../../eb_repository.dart';

final class TestHomeRepository implements HomeRepositoryAB {
  final List<SchedulePath> schedulePathList;
  final List<String> transportNameList;

  TestHomeRepository({
    required this.schedulePathList,
    required this.transportNameList,
  });

  @override
  Future<NetworkResponse<List<SchedulePath>>> getAllSchedules({
    required String accessToken,
  }) async {
    return SuccessResponse(
      statusCode: 200,
      model: schedulePathList,
    );
  }

  @override
  Future<NetworkResponse<List<RealTimeInfo>>> getBusRealTimeInfo({
    required int stationID,
  }) async {
    final mockRealTimeInfo = await delayMockRealTimeInfoList();
    return SuccessResponse(
      statusCode: 200,
      model: mockRealTimeInfo,
    );
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

  @override
  Future<NetworkResponse<List<RealTimeInfo>>> getSubwayRealTimeInfo({
    required String stationName,
    required String lineName,
    required int direction,
  }) async {
    final mockRealTimeInfo = await delayMockRealTimeInfoList();
    return SuccessResponse(
      statusCode: 200,
      model: mockRealTimeInfo,
    );
  }
}
