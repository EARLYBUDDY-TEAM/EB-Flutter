part of '../eb_event.dart';

final class ScheduleEvent {
  final LoadingDelegate _loadingDelegate;
  final ScheduleRepository _scheduleRepository;
  final TokenEvent _tokenEvent;

  ScheduleEvent({
    required LoadingDelegate loadingDelegate,
    required ScheduleRepository scheduleRepository,
    required TokenEvent tokenEvent,
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

    Future<Result> createScheduleEvent(String accessToken) async {
      return await _scheduleRepository.create(
        accessToken: accessToken,
        schedule: schedule,
        ebPath: ebPath,
      );
    }

    final Result addScheduleResult =
        await _tokenEvent.checkExpired(withEvent: createScheduleEvent);

    _loadingDelegate.dismiss();

    switch (addScheduleResult) {
      case Success():
        successAction();
      case Failure():
        if (addScheduleResult.failure is FailureResponse) {
          if (addScheduleResult.failure.statusCode != 490) {
            failAction();
          }
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

    Future<Result> updateScheduleEvent(String accessToken) async {
      return await _scheduleRepository.update(
        accessToken: accessToken,
        schedule: schedule,
        ebPath: ebPath,
      );
    }

    final Result updateScheduleResult =
        await _tokenEvent.checkExpired(withEvent: updateScheduleEvent);

    _loadingDelegate.dismiss();

    switch (updateScheduleResult) {
      case Success():
        successAction();
      case Failure():
        if (updateScheduleResult.failure is FailureResponse) {
          if (updateScheduleResult.failure.statusCode != 490) {
            failAction();
          }
        }
    }
  }

  Future<void> delete({
    required String scheduleID,
    required Function() successAction,
    required Function() failAction,
  }) async {
    _loadingDelegate.set();

    Future<Result> deleteScheduleEvent(String accessToken) async {
      return _scheduleRepository.delete(
        accessToken: accessToken,
        scheduleID: scheduleID,
      );
    }

    final Result deleteScheduleResult =
        await _tokenEvent.checkExpired(withEvent: deleteScheduleEvent);

    _loadingDelegate.dismiss();

    switch (deleteScheduleResult) {
      case Success():
        successAction();

      case Failure():
        if (deleteScheduleResult.failure is FailureResponse) {
          if (deleteScheduleResult.failure.statusCode != 490) {
            failAction();
          }
        }
    }
  }
}
