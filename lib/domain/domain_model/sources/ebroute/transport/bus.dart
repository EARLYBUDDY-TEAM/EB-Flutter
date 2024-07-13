part of '../../domain_model.dart';

final class Bus extends Equatable {
  final String number;
  final String type;

  const Bus({
    required this.number,
    required this.type,
  });

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
    return const Bus(number: '301', type: '간선');
  }
}
