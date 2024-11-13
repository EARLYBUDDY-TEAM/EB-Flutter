part of '../../entity.dart';

typedef StreamRealTimeInfo = Stream<List<RealTimeInfo>>;

final class RealTimeInfo extends Equatable {
  final String transportName;
  final int? arrivalSec1;
  final int? leftStation1;
  final int? arrivalSec2;
  final int? leftStation2;

  const RealTimeInfo({
    required this.transportName,
    required this.arrivalSec1,
    required this.leftStation1,
    required this.arrivalSec2,
    required this.leftStation2,
  });

  @override
  List<Object?> get props => [
        transportName,
        arrivalSec1,
        leftStation1,
        arrivalSec2,
        leftStation2,
      ];

  RealTimeInfo.fromDTO({required RealTimeInfoDTO dto})
      : transportName = dto.transportNumber,
        arrivalSec1 = dto.arrivalSec1,
        arrivalSec2 = dto.arrivalSec2,
        leftStation1 = dto.leftStation1,
        leftStation2 = dto.leftStation2;

  static RealTimeInfo mock({
    String? transportName,
  }) {
    const oneHour = 3600;
    final arrivalSec1 = EBRandom.nexInt(min: 1, max: oneHour);
    final arrivalSec2 = EBRandom.nexInt(min: 1, max: oneHour);
    final leftStation1 = EBRandom.nexInt(min: 1, max: 10);
    final leftStation2 = EBRandom.nexInt(min: 1, max: 10);
    final newTransportName = transportName ?? DefaultValue.String;

    return RealTimeInfo(
      transportName: newTransportName,
      arrivalSec1: arrivalSec1,
      leftStation1: leftStation1,
      arrivalSec2: arrivalSec2,
      leftStation2: leftStation2,
    );
  }
}
