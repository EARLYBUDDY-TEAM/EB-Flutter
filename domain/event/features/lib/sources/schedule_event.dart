part of '../eb_event.dart';

final class ScheduleEvent {
  final LoadingDelegate _loadingDelegate;
  final ScheduleRepository _scheduleRepository;
  final EBTokenEvent _tokenEvent;

  ScheduleEvent({
    required LoadingDelegate loadingDelegate,
    required ScheduleRepository scheduleRepository,
    required EBTokenEvent tokenEvent,
  })  : _loadingDelegate = loadingDelegate,
        _scheduleRepository = scheduleRepository,
        _tokenEvent = tokenEvent;

  Future<void> create({
    required Schedule schedule,
    required EBPath? ebPath,
    required Function() successAction,
    required Function() failAction,
  }) async {
    _loadingDelegate.set();

    Future<NetworkResponse<EmptyDTO>> createScheduleEvent(
        String accessToken) async {
      return await _scheduleRepository.create(
        accessToken: accessToken,
        schedule: schedule,
        ebPath: ebPath,
      );
    }

    final NetworkResponse<EmptyDTO> addScheduleResult =
        await _tokenEvent.checkExpired(withEvent: createScheduleEvent);

    _loadingDelegate.dismiss();

    switch (addScheduleResult) {
      case SuccessResponse():
        successAction();
      case FailureResponse():
        if (addScheduleResult.statusCode != 490) {
          failAction();
        }
    }
  }

  Future<void> update({
    required Schedule schedule,
    required EBPath? ebPath,
    required Function() successAction,
    required Function() failAction,
  }) async {
    _loadingDelegate.set();

    Future<NetworkResponse<EmptyDTO>> updateScheduleEvent(
        String accessToken) async {
      return await _scheduleRepository.update(
        accessToken: accessToken,
        schedule: schedule,
        ebPath: ebPath,
      );
    }

    final NetworkResponse<EmptyDTO> updateScheduleResult =
        await _tokenEvent.checkExpired(withEvent: updateScheduleEvent);

    _loadingDelegate.dismiss();

    switch (updateScheduleResult) {
      case SuccessResponse():
        successAction();
      case FailureResponse():
        if (updateScheduleResult.statusCode != 490) {
          failAction();
        }
    }
  }

  Future<void> delete({
    required String scheduleID,
    required Function() successAction,
    required Function() failAction,
  }) async {
    _loadingDelegate.set();

    Future<NetworkResponse<EmptyDTO>> deleteScheduleEvent(
        String accessToken) async {
      return _scheduleRepository.delete(
        accessToken: accessToken,
        scheduleID: scheduleID,
      );
    }

    final NetworkResponse<EmptyDTO> deleteScheduleResult =
        await _tokenEvent.checkExpired(withEvent: deleteScheduleEvent);

    _loadingDelegate.dismiss();

    switch (deleteScheduleResult) {
      case SuccessResponse():
        successAction();

      case FailureResponse():
        if (deleteScheduleResult.statusCode != 490) {
          failAction();
        }
    }
  }
}
