part of '../domain_model.dart';

final class Place extends Equatable {
  final String id;
  final String name;
  final String address;
  final String category;
  final String distance;
  final Coordi coordi;

  const Place({
    required this.id,
    required this.name,
    required this.address,
    required this.category,
    required this.distance,
    required this.coordi,
  });

  Place.fromDTO({
    required PlaceDTO placeDTO,
  })  : id = placeDTO.id,
        name = placeDTO.name,
        address = placeDTO.address,
        category = placeDTO.category,
        distance = (double.parse(placeDTO.distance) / 1000).toStringAsFixed(1),
        coordi = Coordi.fromDTO(coordiDTO: placeDTO.coordi);

  static Place mockView() {
    final random = Random().nextBool();
    final name = random ? '테스트장소이름' : '테스트 장소이름 테스트장소 이름테스트장 소이름';
    final address =
        random ? '테스트도로명주소' : '테스트 도로명주 소 테 스 트    도로명  주소테스    트도  로명주소';
    final category = random ? '테스트카테고리' : '테스트카테고리테스트카테고리테스트카테고리테스트카테고리';
    const distance = '1.2';

    return Place(
      id: UniqueKey().toString(),
      name: name,
      address: address,
      category: category,
      distance: distance,
      coordi: const Coordi(x: '0', y: '0'),
    );
  }

  static Place mockStarBucks() {
    return const Place(
      id: '2140311573',
      name: '스타벅스 수서역R점',
      address: '서울 강남구 광평로 281',
      category: '카페',
      distance: '0.1',
      coordi: Coordi(x: '127.10297988971773', y: '37.48800665367514'),
    );
  }

  static Place mockStart() {
    return const Place(
      id: '123',
      name: '멜로즈',
      address: '서울 용산구 보광로 82',
      category: '카페',
      distance: '12',
      coordi: Coordi(x: '126.996509759576', y: '37.5306176474415'),
    );
  }

  static Place mockEnd() {
    return mockStarBucks();
  }

  @override
  List<Object?> get props => [name, address, coordi];
}
