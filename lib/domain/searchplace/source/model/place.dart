part of 'model.dart';

final class Place extends Equatable {
  final String name;
  final String address;
  final Coordi coordi;

  const Place({
    required this.name,
    required this.address,
    required this.coordi,
  });

  Place.fromDTO({
    required PlaceDTO placeDTO,
  })  : name = placeDTO.placeName,
        address = placeDTO.roadAddress,
        coordi = Coordi.fromDTO(coordiDTO: placeDTO.coordi);

  @override
  List<Object?> get props => [name, address, coordi];
}

final class Coordi extends Equatable {
  final String x;
  final String y;

  const Coordi({
    required this.x,
    required this.y,
  });

  Coordi.fromDTO({
    required CoordiDTO coordiDTO,
  })  : x = coordiDTO.x,
        y = coordiDTO.y;

  @override
  List<Object?> get props => [x, y];
}
