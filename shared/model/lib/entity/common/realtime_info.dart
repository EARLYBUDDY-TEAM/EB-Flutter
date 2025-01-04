part of '../../entity.dart';

typedef StreamRealTimeInfo = Stream<List<RealTimeInfo>>;

final class ArrivalInfo {
  final String? transportPlate;
  final int? arrivalSec;
  final int? leftStation;

  const ArrivalInfo({
    required this.transportPlate,
    required this.arrivalSec,
    required this.leftStation,
  });

  ArrivalInfo.fromDTO({required ArrivalInfoDTO dto})
      : transportPlate = dto.transportPlate,
        arrivalSec = dto.arrivalSec,
        leftStation = dto.leftStation;

  static ArrivalInfo mock() {
    const oneHour = 3600;
    return ArrivalInfo(
      transportPlate: DefaultValue.String,
      arrivalSec: EBRandom.nexInt(min: 1, max: oneHour),
      leftStation: EBRandom.nexInt(min: 1, max: 10),
    );
  }
}

final class RealTimeInfo extends Equatable {
  final String transportName;
  final ArrivalInfo arrivalInfo1;
  final ArrivalInfo arrivalInfo2;

  const RealTimeInfo({
    required this.transportName,
    required this.arrivalInfo1,
    required this.arrivalInfo2,
  });

  @override
  List<Object?> get props => [
        transportName,
        arrivalInfo1,
        arrivalInfo2,
      ];

  RealTimeInfo.fromDTO({required RealTimeInfoDTO dto})
      : transportName = dto.transportNumber,
        arrivalInfo1 = ArrivalInfo.fromDTO(dto: dto.arrivalInfoDTO1),
        arrivalInfo2 = ArrivalInfo.fromDTO(dto: dto.arrivalInfoDTO2);

  static RealTimeInfo mock({
    String? transportName,
  }) {
    final newTransportName = transportName ?? DefaultValue.String;

    return RealTimeInfo(
      transportName: newTransportName,
      arrivalInfo1: ArrivalInfo.mock(),
      arrivalInfo2: ArrivalInfo.mock(),
    );
  }

  static RealTimeInfo? getRealTimeInfo({
    required List<RealTimeInfo>? realTimeInfoList,
    required Transport? selectedTransport,
  }) {
    if (realTimeInfoList == null) {
      return null;
    }

    if (selectedTransport == null) {
      return null;
    }
    String transportName;
    switch (selectedTransport) {
      case Subway():
        transportName = selectedTransport.type;
      case Bus():
        transportName = selectedTransport.number;
    }

    for (var realTimeInfo in realTimeInfoList) {
      if (realTimeInfo.transportName == transportName) {
        return realTimeInfo;
      }
    }

    return null;
  }
}
