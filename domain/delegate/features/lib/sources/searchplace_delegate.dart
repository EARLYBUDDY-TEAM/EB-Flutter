part of '../eb_delegate.dart';

final class SearchPlaceDelegate {
  final backFromFindRouteView = PublishSubject<void>();

  Future<void> dispose() async {
    await backFromFindRouteView.close();
  }
}
