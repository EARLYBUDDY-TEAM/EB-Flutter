part of '../eb_repository_interface.dart';

abstract class HomeRepositoryAB {
  /// 모든 스케줄 정보 가져오기
  Future<Result> getAllSchedules({
    required String accessToken,
  }) async {
    throw UnimplementedError('구현부');
  }

  /// 버스 실시간 정보 가져오기
  Future<Result> getBusRealTimeInfo({
    required int stationID,
  }) async {
    throw UnimplementedError('구현부');
  }

  /// 지하철 모든 시간표 정보 가져오기
  Future<Result> getTotalSubwaySchedule({
    required int stationID,
    required int wayCode,
  }) async {
    throw UnimplementedError('구현부');
  }

  /// 지하철 실시간 정보 가져오기
  Future<Result> getSubwayRealTimeInfo({
    required String stationName,
    required String lineName,
    required int direction,
  }) async {
    throw UnimplementedError('구현부');
  }
}
