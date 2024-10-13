part of '../dto.dart';

final class PlaceListDTO {
  final List<PlaceDTO> places;
  final PlaceMetaDTO meta;

  PlaceListDTO({
    required this.places,
    required this.meta,
  });

  static PlaceListDTO fromJson(Map<String, dynamic> j) {
    final placeList = j['documents'] as List;
    final places = placeList.map((p) => PlaceDTO.fromKakaoJson(p)).toList();
    final meta = PlaceMetaDTO.fromJson(j['meta']);
    return PlaceListDTO(places: places, meta: meta);
  }
}

final class PlaceMetaDTO {
  final bool isEnd;

  PlaceMetaDTO({required this.isEnd});

  static PlaceMetaDTO fromJson(Map<String, dynamic> j) {
    return PlaceMetaDTO(isEnd: j['is_end']);
  }
}

final class PlaceDTO {
  final String id;
  final String name;
  final String address;
  final String category;
  final String distance;
  final CoordiDTO coordi;

  PlaceDTO({
    required this.id,
    required this.name,
    required this.address,
    required this.category,
    required this.distance,
    required this.coordi,
  });

  static PlaceDTO fromKakaoJson(Map<String, dynamic> j) {
    return PlaceDTO(
      id: j['id'],
      name: j['place_name'],
      address: j['road_address_name'],
      category: j['category_group_name'],
      distance: j['distance'],
      coordi: CoordiDTO(
        x: j['x'],
        y: j['y'],
      ),
    );
  }

  static PlaceDTO fromEBServerJson(Map<String, dynamic> j) {
    final Map<String, dynamic> coordiJson = j['coordi'];
    final coordi = CoordiDTO.fromEBServerJson(coordiJson);

    return PlaceDTO(
      id: j['id'],
      name: j['name'],
      address: j['address'],
      category: j['category'],
      distance: j['distance'],
      coordi: coordi,
    );
  }
}

final class CoordiDTO {
  final String x;
  final String y;

  CoordiDTO({
    required this.x,
    required this.y,
  });

  static CoordiDTO fromEBServerJson(Map<String, dynamic> j) {
    return CoordiDTO(
      x: j['x'],
      y: j['y'],
    );
  }
}
