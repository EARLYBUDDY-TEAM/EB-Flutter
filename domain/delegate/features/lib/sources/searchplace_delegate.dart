part of '../eb_delegate.dart';

class SearchPlaceDelegate {
  final selectPlace = PublishSubject<Place>();

  Future<void> dispose() async {
    await selectPlace.close();
  }
}

class SearchPlaceDelegateForPlace extends SearchPlaceDelegate {}

class SearchPlaceDelegateForRoute extends SearchPlaceDelegate {}
