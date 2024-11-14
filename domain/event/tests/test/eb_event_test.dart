import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eb_event/eb_event.dart';
import 'package:eb_model/eb_model.dart';
import 'package:eb_uikit/eb_uikit.dart';
import 'package:intl/intl.dart';

void main() {
  test('Get RealTimeInfo from TotalSubwaySchedule', () {
    const Transport? optionalSubway = null;
    final Transport mockSubway = Subway.mock();

    final Subway? castedSubway = castOrNull<Subway>(optionalSubway);
    log(castedSubway.toString());

    // final mockTotalSubwaySchedule = TotalSubwaySchedule.mock();
    // final mockSubway = Subway(type: '1호선');

    // final subwayScheduleList =
    //     selectSubwayScheduleList(mockTotalSubwaySchedule);

    // final arrivalMinuteList =
    //     getArrivalSecFromSubwayScheduleList(subwayScheduleList);
    // log(arrivalMinuteList.toString());

    // final realTimeInfo = RealTimeInfo(
    //   transportName: mockSubway.type,
    //   arrivalSec1: 0,
    //   leftStation1: 0,
    //   arrivalSec2: 0,
    //   leftStation2: 0,
    // );
  });
}
