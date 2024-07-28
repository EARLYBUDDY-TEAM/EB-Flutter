import 'package:earlybuddy/domain/domain_model/domain_model.dart';
import 'package:earlybuddy/domain/network/sources/endpoint/endpoint.dart';
import 'package:earlybuddy/domain/network/sources/service/service.dart';

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
