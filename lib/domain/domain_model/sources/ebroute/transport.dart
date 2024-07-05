part of '../domain_model.dart';

final class Transport extends Equatable {
  final String? subwayName;
  final String? busName;

  const Transport({
    required this.subwayName,
    required this.busName,
  });

  Transport.fromDTO({required TransportDTO transportDTO})
      : subwayName = transportDTO.subwayName,
        busName = transportDTO.busName;

  @override
  List<Object?> get props => [subwayName, busName];

  static Transport mockBus() {
    return const Transport(
      subwayName: null,
      busName: '401',
    );
  }

  static Transport mockSubway() {
    return const Transport(
      subwayName: '3호선',
      busName: null,
    );
  }
}
