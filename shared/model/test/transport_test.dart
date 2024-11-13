import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:eb_model/eb_model.dart';

void main() {
  // test('Test Transport toDTO', () {
  //   final mockSubway = Subway.mock() as Transport;
  //   final mockBus = Bus.mock() as Transport;

  //   final toDTOMockSubway = mockSubway.toDTO();
  //   log(toDTOMockSubway.busNumber.toString());
  //   log(toDTOMockSubway.busType.toString());
  //   log(toDTOMockSubway.subwayType.toString());
  // });

  test('Test Transport List', () {
    final mockSubwayList = [
      Subway.mock(),
      Subway.mock(),
      Subway.mock(),
    ] as List<Transport>;
    final mockBusList = [
      Bus.mock(),
      Bus.mock(),
      Bus.mock(),
    ] as List<Transport>;

    switch (mockSubwayList) {
      case List<Subway>():
        final firstSubway = mockSubwayList.firstOrNull;
        log("subway type");
        log(firstSubway?.type ?? "efafe");
      case List<Bus>():
        final firstBus = mockSubwayList.firstOrNull;
        log("bus type");
        log(firstBus?.number ?? "efafe");
    }
  });
}
