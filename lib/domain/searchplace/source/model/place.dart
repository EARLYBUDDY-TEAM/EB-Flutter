part of 'model.dart';

final class Place extends Equatable {
  final String name;
  final String address;
  final String category;
  final Coordi coordi;

  const Place({
    required this.name,
    required this.address,
    required this.category,
    required this.coordi,
  });

  Place.fromDTO({
    required PlaceDTO placeDTO,
  })  : name = placeDTO.name,
        address = placeDTO.address,
        category = placeDTO.category,
        coordi = Coordi.fromDTO(coordiDTO: placeDTO.coordi);

  static Place mock() {
    final random = Random().nextBool();
    final name = random ? '테스트장소이름' : '테스트 장소이름 테스트장소 이름테스트장 소이름';
    final address =
        random ? '테스트도로명주소' : '테스트 도로명주 소 테 스 트    도로명  주소테스    트도  로명주소';
    final category = random ? '테스트카테고리' : '테스트카테고리테스트카테고리테스트카테고리테스트카테고리';

    return Place(
      name: name,
      address: address,
      category: category,
      coordi: const Coordi(x: '0', y: '0'),
    );
  }

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
