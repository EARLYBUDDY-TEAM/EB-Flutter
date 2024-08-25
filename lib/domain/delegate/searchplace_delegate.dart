import 'dart:async';
import 'package:earlybuddy/shared/eb_model/entity/entity.dart';

class SearchPlaceDelegate {
  final _selectPlaceController = StreamController<Place>.broadcast();

  SearchPlaceDelegate();

  Stream<Place> get pressSelectPlaceButton async* {
    yield* _selectPlaceController.stream;
  }

  void addPressSelectPlaceButton(Place selectedPlace) {
    _selectPlaceController.add(selectedPlace);
  }

  void dispose() => _selectPlaceController.close();
}

class SearchPlaceDelegateForPlace extends SearchPlaceDelegate {}

class SearchPlaceDelegateForRoute extends SearchPlaceDelegate {}
