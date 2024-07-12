// import 'dart:async';
// import 'package:earlybuddy/domain/repository/searchplace/source/model/model.dart';

// class SearchPlaceEventDelegate {
//   SearchPlaceEventDelegate._singletonConstructor();
//   static final SearchPlaceEventDelegate shared =
//       SearchPlaceEventDelegate._singletonConstructor();

//   SearchPlaceEventDelegate();

//   final _selectPlaceButtonPressedController = StreamController<Place>();
//   late final selectPlaceButtonPressed =
//       _selectPlaceButtonPressedController.stream;
//   void sinkSelectPlaceButtonPressed({required Place place}) {
//     _selectPlaceButtonPressedController.sink.add(place);
//   }

//   final _cancelButtonPressedController = StreamController<void>();
//   late final cancelButtonPressed = _cancelButtonPressedController.stream;
//   void sinkCancelButtonPressed() {
//     _cancelButtonPressedController.sink.add(());
//   }
// }
