import 'package:earlybuddy/shared/eb_model/entity/entity.dart';
import 'package:earlybuddy/core/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/core/network/sources/service/service.dart';

final class ScheduleRepository {
  final NetworkService service;

  ScheduleRepository({
    NetworkService? networkService,
  }) : service = networkService ?? NetworkService.shared;

  Future<int> addSchedule({
    required ScheduleInfo scheduleInfo,
  }) async {
    final request = AddScheduleRequest.init(scheduleInfo.toMap());
    final result = await service.request(request);

    switch (result) {
      case (Success()):
        return result.statusCode;
      case (Failure()):
        return result.statusCode;
    }
  }
}
