part of '../../../entity.dart';

final class BusList extends TransportList {
  final List<Bus> busList;

  BusList({
    required this.busList,
  });

  List<TransportDTO> toDTO() {
    return busList.map((b) => b.toDTO()).toList();
  }

  @override
  List<Object?> get props => [busList];
}

final class Bus extends Transport {
  final String number;
  final String type;

  Bus({
    required this.number,
    required this.type,
  });

  static Bus fromDTO({required TransportDTO transportDTO}) {
    final number = transportDTO.busNumber ?? DefaultValue.String;
    final type = transportDTO.busType ?? DefaultValue.String;
    return Bus(
      number: number,
      type: type,
    );
  }

  TransportDTO toDTO() {
    return TransportDTO(
      subwayType: null,
      busNumber: number,
      busType: type,
    );
  }

  Color color() {
    switch (type) {
      case '간선':
        return EBColors.bus.ganson;
      case '지선':
        return EBColors.bus.jison;
      case '광역':
        return EBColors.bus.gwangyok;
      default:
        return EBColors.bus.others;
    }
  }

  @override
  List<Object?> get props => [number, type];

  static Bus mock() {
    final random = Random();
    final int num = 100 + random.nextInt(999 - 100);
    return Bus(number: "$num", type: '지선');
  }
}
