import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:eb_model/eb_model.dart';

DateTime? deparetureTimeStringToDateTime(String departureTime) {
  final List<int> departureTimeList = departureTime
      .split(":")
      .map<int>(
        (e) => int.parse(e),
      )
      .toList();

  if (departureTimeList.length != 2) {
    return null;
  }

  final int hour = departureTimeList[0];
  final int minute = departureTimeList[1];

  final time = DateTime.now().copyWith(
    hour: hour,
    minute: minute,
  );

  return time;
}

void main() {
  test("Test SubwaySchedule fromDTO", () {
    const departureTimeString = "08:13";
    final mockDTO = SubwayScheduleDTO(
      departureTime: departureTimeString,
      firstLastFlag: 1,
    );

    final firstLastFlag = (mockDTO.firstLastFlag == 1) ? true : false;
    // 2024-11-14 08:13:21.684015
    final deparetureTime = deparetureTimeStringToDateTime(departureTimeString);
  });

  // test('Test Transport toDTO', () {
  //   final mockSubway = Subway.mock() as Transport;
  //   final mockBus = Bus.mock() as Transport;

  //   final toDTOMockSubway = mockSubway.toDTO();
  //   log(toDTOMockSubway.busNumber.toString());
  //   log(toDTOMockSubway.busType.toString());
  //   log(toDTOMockSubway.subwayType.toString());
  // });

  // test('Test Transport List', () {
  //   final mockSubwayList = [
  //     Subway.mock(),
  //     Subway.mock(),
  //     Subway.mock(),
  //   ] as List<Transport>;
  //   final mockBusList = [
  //     Bus.mock(),
  //     Bus.mock(),
  //     Bus.mock(),
  //   ] as List<Transport>;

  //   switch (mockSubwayList) {
  //     case List<Subway>():
  //       final firstSubway = mockSubwayList.firstOrNull;
  //       log("subway type");
  //       log(firstSubway?.type ?? "efafe");
  //     case List<Bus>():
  //       final firstBus = mockSubwayList.firstOrNull;
  //       log("bus type");
  //       log(firstBus?.number ?? "efafe");
  //   }
  // });
}
