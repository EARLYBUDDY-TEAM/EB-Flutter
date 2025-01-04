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
  final ArrivalInfoDTO arrivalInfoDTO1;
  final ArrivalInfoDTO arrivalInfoDTO2;

  RealTimeInfoDTO({
    required this.transportNumber,
    required this.arrivalInfoDTO1,
    required this.arrivalInfoDTO2,
  });

  static RealTimeInfoDTO fromJson(Map<String, dynamic> j) {
    return RealTimeInfoDTO(
      transportNumber: j['transport_number'],
      arrivalInfoDTO1: ArrivalInfoDTO.fromJson(j['arrival_info1']),
      arrivalInfoDTO2: ArrivalInfoDTO.fromJson(j['arrival_info2']),
    );
  }
}

final class ArrivalInfoDTO {
  final String? transportPlate;
  final int? arrivalSec;
  final int? leftStation;

  ArrivalInfoDTO({
    required this.transportPlate,
    required this.arrivalSec,
    required this.leftStation,
  });

  static ArrivalInfoDTO fromJson(Map<String, dynamic> j) {
    return ArrivalInfoDTO(
      transportPlate: j['transport_plate'],
      arrivalSec: j['arrival_sec'],
      leftStation: j['left_station'],
    );
  }
}
