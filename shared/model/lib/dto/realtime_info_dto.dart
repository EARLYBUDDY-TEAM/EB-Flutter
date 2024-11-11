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
  final int? arrivalSec1;
  final int? arrivalSec2;
  final String transportNumber;

  RealTimeInfoDTO({
    required this.arrivalSec1,
    required this.arrivalSec2,
    required this.transportNumber,
  });

  static RealTimeInfoDTO fromJson(Map<String, dynamic> j) {
    return RealTimeInfoDTO(
      arrivalSec1: j['arrival_sec1'],
      arrivalSec2: j['arrival_sec2'],
      transportNumber: j['transport_number'],
    );
  }
}


// {
//   "real_time_info_list": [
//     {
//       "transport_number": "101",
//       "arrival_sec1": 415,
//       "arrival_sec2": 769
//     },
//     {
//       "transport_number": "103",
//       "arrival_sec1": 202,
//       "arrival_sec2": 637
//     },
//     {
//       "transport_number": "105",
//       "arrival_sec1": 264,
//       "arrival_sec2": 862
//     },
//     {
//       "transport_number": "144",
//       "arrival_sec1": 532,
//       "arrival_sec2": 930
//     },
//     {
//       "transport_number": "152",
//       "arrival_sec1": 409,
//       "arrival_sec2": 985
//     },
//     {
//       "transport_number": "201",
//       "arrival_sec1": 410,
//       "arrival_sec2": 1377
//     },
//     {
//       "transport_number": "260",
//       "arrival_sec1": 22,
//       "arrival_sec2": 792
//     },
//     {
//       "transport_number": "261",
//       "arrival_sec1": 284,
//       "arrival_sec2": 894
//     },
//     {
//       "transport_number": "262",
//       "arrival_sec1": 276,
//       "arrival_sec2": 834
//     },
//     {
//       "transport_number": "270",
//       "arrival_sec1": 243,
//       "arrival_sec2": 785
//     },
//     {
//       "transport_number": "271",
//       "arrival_sec1": 417,
//       "arrival_sec2": 851
//     },
//     {
//       "transport_number": "370",
//       "arrival_sec1": 105,
//       "arrival_sec2": 209
//     },
//     {
//       "transport_number": "420",
//       "arrival_sec1": 27,
//       "arrival_sec2": 582
//     },
//     {
//       "transport_number": "720",
//       "arrival_sec1": 545,
//       "arrival_sec2": 1483
//     },
//     {
//       "transport_number": "721",
//       "arrival_sec1": 182,
//       "arrival_sec2": 623
//     },
//     {
//       "transport_number": "2112",
//       "arrival_sec1": 190,
//       "arrival_sec2": 1198
//     },
//     {
//       "transport_number": "2233",
//       "arrival_sec1": 592,
//       "arrival_sec2": 1502
//     },
//     {
//       "transport_number": "6002",
//       "arrival_sec1": 392,
//       "arrival_sec2": 2862
//     },
//     {
//       "transport_number": "N26",
//       "arrival_sec1": null,
//       "arrival_sec2": null
//     },
//     {
//       "transport_number": "N30",
//       "arrival_sec1": null,
//       "arrival_sec2": null
//     },
//     {
//       "transport_number": "N13",
//       "arrival_sec1": null,
//       "arrival_sec2": null
//     },
//     {
//       "transport_number": "N15",
//       "arrival_sec1": null,
//       "arrival_sec2": null
//     },
//     {
//       "transport_number": "심야A21",
//       "arrival_sec1": null,
//       "arrival_sec2": null
//     },
//     {
//       "transport_number": "111",
//       "arrival_sec1": 1010,
//       "arrival_sec2": 2146
//     },
//     {
//       "transport_number": "N51",
//       "arrival_sec1": null,
//       "arrival_sec2": null
//     }
//   ]
// }