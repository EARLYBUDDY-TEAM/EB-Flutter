part of '../../../entity.dart';

final class Station extends Equatable {
  final String name;

  const Station({
    required this.name,
  });

  static Station fromDTO({required StationDTO stationDTO}) {
    return Station(name: stationDTO.name);
  }

  StationDTO toDTO() {
    return StationDTO(name: name);
  }

  @override
  List<Object?> get props => [name];
}
