part of '../eb_delegate.dart';

final class AddScheduleDelegate {
  final selectEndPlace = PublishSubject<Place>();
  final selectStartPlace = PublishSubject<Place>();

  final cancelEndView = PublishSubject<void>();
  final cancelStartView = PublishSubject<void>();

  Future<void> dispose() async {
    await selectEndPlace.close();
    await selectStartPlace.close();
    await cancelEndView.close();
    await cancelStartView.close();
  }
}
