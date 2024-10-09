part of '../eb_repository_interface.dart';

abstract class HomeRepositoryAB {
  /// 모든 스케줄 정보 가져오기
  Future<Result> getAllScheduleCards({
    required String accessToken,
  }) async {
    throw UnimplementedError('구현부');
  }

  // 스케줄 지우기
  Future<Result> deleteScheduleCard({
    required String accessToken,
    required int scheduleID,
  }) async {
    throw UnimplementedError('구현부');
  }
}
