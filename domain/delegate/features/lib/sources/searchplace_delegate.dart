part of '../eb_delegate.dart';

final class SearchPlaceDelegate {
  final backFindRouteView = PublishSubject<void>();

  Future<void> dispose() async {
    await backFindRouteView.close();
  }
}
