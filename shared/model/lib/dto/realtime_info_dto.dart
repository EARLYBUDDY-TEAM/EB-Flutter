part of '../dto.dart';

final class RealTimeInfoDTOList {
  final List<RealTimeInfoDTO> realTimeInfoDTOList;

  RealTimeInfoDTOList({
    required this.realTimeInfoDTOList,
  });

  static RealTimeInfoDTOList fromJson(Map<String, dynamic> j) {
    final tmpRealTimeInfoDTOList = j['real_time_info_list'] as List;

    final realTimeInfoDTOList = tmpRealTimeInfoDTOList
        .map<RealTimeInfoDTO>((r) => RealTimeInfoDTO.fromJson(r))
        .toList();
    return RealTimeInfoDTOList(realTimeInfoDTOList: realTimeInfoDTOList);
  }
}

final class RealTimeInfoDTO {
  final String transportNumber;
  final int? arrivalSec1;
  final int? arrivalSec2;
  final int? leftStation1;
  final int? leftStation2;

  RealTimeInfoDTO({
    required this.transportNumber,
    required this.arrivalSec1,
    required this.arrivalSec2,
    required this.leftStation1,
    required this.leftStation2,
  });

  static RealTimeInfoDTO fromJson(Map<String, dynamic> j) {
    return RealTimeInfoDTO(
      transportNumber: j['transport_number'],
      arrivalSec1: j['arrival_sec1'],
      arrivalSec2: j['arrival_sec2'],
      leftStation1: j['left_station1'],
      leftStation2: j['left_station2'],
    );
  }
}
