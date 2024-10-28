part of '../eb_delegate.dart';

final class AddScheduleDelegate {
  final selectEndPlace = PublishSubject<Place>();
  final selectStartPlace = PublishSubject<PathInfo>();
  final cancelModalView = PublishSubject<void>();

  Future<void> dispose() async {
    await selectEndPlace.close();
    await selectStartPlace.close();
    await cancelModalView.close();
  }
}
