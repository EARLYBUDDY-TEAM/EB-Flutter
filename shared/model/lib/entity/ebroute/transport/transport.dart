part of '../../../entity.dart';

// Transport => SealedTransport 변경
final class Transport extends Equatable {
  final Subway? subway;
  final Bus? bus;
  final Walk? walk;

  const Transport({
    this.subway,
    this.bus,
    this.walk,
  });

  Map<String, dynamic> toMap() {
    return {
      "subwayType": subway?.type,
      "busNumber": "${bus?.number}",
      "busType": bus?.type,
    };
  }

  static Transport fromDTO({required TransportDTO transportDTO}) {
    Subway? subway;
    Bus? bus;
    Walk? walk;

    if (transportDTO.subwayType != null) {
      subway = Subway(type: transportDTO.subwayType!);
    } else if ((transportDTO.busNumber != null) &&
        (transportDTO.busType != null)) {
      bus = Bus(number: transportDTO.busNumber!, type: transportDTO.busType!);
    } else {
      walk = Walk();
    }

    return Transport(subway: subway, bus: bus, walk: walk);
  }

  @override
  List<Object?> get props => [subway, bus];

  static Transport mockBus() {
    return Transport(
      bus: Bus.mock(),
    );
  }

  static Transport mockSubway() {
    return Transport(
      subway: Subway.mock(),
    );
  }

  Transport.walk()
      : subway = null,
        bus = null,
        walk = Walk();
}
