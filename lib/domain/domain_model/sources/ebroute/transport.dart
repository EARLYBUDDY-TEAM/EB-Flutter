part of '../domain_model.dart';

final class Transport extends Equatable {
  final Subway? subway;
  final Bus? bus;

  const Transport({
    required this.subway,
    required this.bus,
  });

  static Transport fromDTO({required TransportDTO transportDTO}) {
    Subway? subway;
    Bus? bus;
    if (transportDTO.subwayType != null) {
      subway = Subway(type: transportDTO.subwayType!);
    }
    if ((transportDTO.busNumber != null) && (transportDTO.busType != null)) {
      bus = Bus(number: transportDTO.busNumber!, type: transportDTO.busType!);
    }

    return Transport(subway: subway, bus: bus);
  }

  @override
  List<Object?> get props => [subway, bus];

  static Transport mockBus() {
    return Transport(
      subway: null,
      bus: Bus.mock(),
    );
  }

  static Transport mockSubway() {
    return Transport(
      subway: Subway.mock(),
      bus: null,
    );
  }
}
