part of '../../entity.dart';

final class RealTimeInfo extends Equatable {
  final int arrivalSec1;
  final int arrivalSec2;

  const RealTimeInfo({
    required this.arrivalSec1,
    required this.arrivalSec2,
  });

  @override
  List<Object?> get props => [
        arrivalSec1,
        arrivalSec2,
      ];

  RealTimeInfo.fromDTO({
    required RealTimeInfoDTO realTimeInfoDTO,
  })  : arrivalSec1 = realTimeInfoDTO.arrivalSec1,
        arrivalSec2 = realTimeInfoDTO.arrivalSec2;

  static RealTimeInfo mock() {
    Random random = Random();
    const oneHour = 3600;
    final arrivalSec1 = random.nextInt(oneHour);
    final arrivalSec2 = random.nextInt(oneHour);
    return RealTimeInfo(
      arrivalSec1: arrivalSec1,
      arrivalSec2: arrivalSec2,
    );
  }
}
