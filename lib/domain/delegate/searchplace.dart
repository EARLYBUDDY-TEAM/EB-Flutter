import 'dart:async';
import 'package:earlybuddy/domain/domain_model/domain_model.dart';

final class SearchPlaceDelegate {
  final _selectPlaceController = StreamController<Place>();

  SearchPlaceDelegate();

  Stream<Place> get pressSelectPlaceButton async* {
    yield* _selectPlaceController.stream;
  }

  void addPressSelectPlaceButton(Place selectedPlace) {
    _selectPlaceController.add(selectedPlace);
  }

  void dispose() => _selectPlaceController.close();
}
