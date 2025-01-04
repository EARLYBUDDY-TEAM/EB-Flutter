part of '../eb_repository_interface.dart';

abstract class HomeRepositoryAB {
  /// 모든 스케줄 정보 가져오기
  Future<NetworkResponse<List<SchedulePath>>> getAllSchedules({
    required String accessToken,
  }) async {
    throw UnimplementedError('구현부');
  }

  /// 버스 실시간 정보 가져오기
  Future<NetworkResponse<List<RealTimeInfo>>> getBusRealTimeInfo({
    required int stationID,
  }) async {
    throw UnimplementedError('구현부');
  }

  /// 지하철 실시간 정보 가져오기
  Future<NetworkResponse<List<RealTimeInfo>>> getSubwayRealTimeInfo({
    required String stationName,
    required String lineName,
    required int direction,
  }) async {
    throw UnimplementedError('구현부');
  }
}
