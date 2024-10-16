part of '../eb_delegate.dart';

final class AddScheduleDelegate {
  final selectEndPlace = PublishSubject<Place>();
  final selectStartPlace = PublishSubject<Place>();

  final cancelEndSearchPlaceView = PublishSubject<void>();
  final cancelStartSearchPlaceView = PublishSubject<void>();
  final cancelFindRouteView = PublishSubject<void>();

  Future<void> dispose() async {
    await selectEndPlace.close();
    await selectStartPlace.close();
    await cancelEndSearchPlaceView.close();
    await cancelStartSearchPlaceView.close();
    await cancelFindRouteView.close();
  }
}
