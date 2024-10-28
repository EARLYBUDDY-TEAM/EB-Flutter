part of '../eb_delegate.dart';

final class FindRouteDelegate {
  final changeEndPlace = PublishSubject<Place>();
  final changeStartPlace = PublishSubject<Place>();

  Future<void> dispose() async {
    await changeEndPlace.close();
    await changeStartPlace.close();
  }
}
