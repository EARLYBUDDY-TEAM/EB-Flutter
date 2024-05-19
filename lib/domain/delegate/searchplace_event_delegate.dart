import 'dart:async';
import 'package:earlybuddy/domain/repository/searchplace/source/model/model.dart';

class SearchPlaceEventDelegate {
  SearchPlaceEventDelegate._singletonConstructor();
  static final SearchPlaceEventDelegate shared =
      SearchPlaceEventDelegate._singletonConstructor();

  SearchPlaceEventDelegate();

  final _selectPlaceButtonPressedController = StreamController<Place>();
  late final selectPlaceButtonPressed =
      _selectPlaceButtonPressedController.stream;

  void sinkSelectPlaceButtonPressed({required Place place}) {
    _selectPlaceButtonPressedController.sink.add(place);
  }
}

// class Singleton {
//   Singleton._privateConstructor();
//   static final Singleton _instance = Singleton._privateConstructor();

//   factory Singleton() {
//     return _instance;
//   }
// }


// final _controller = StreamController<EBAuthInfo>();
//   final NetworkService service = NetworkService();

//   Stream<EBAuthInfo> get authInfo async* {
//     await Future<void>.delayed(const Duration(seconds: 1));
//     yield const EBAuthInfo.unAuth();
//     yield* _controller.stream;
//   }

//   void dispose() => _controller.close();