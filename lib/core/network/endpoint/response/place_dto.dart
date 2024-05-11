final class PlaceListDTO {
  final List<PlaceDTO> places;
  final PlaceMetaDTO meta;

  PlaceListDTO({
    required this.places,
    required this.meta,
  });

  static PlaceListDTO fromJson(Map<String, dynamic> j) {
    final placeList = j['documents'] as List;
    final places = placeList.map((p) => PlaceDTO.fromJson(p)).toList();
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
  final String name;
  final String address;
  final String category;
  final CoordiDTO coordi;

  PlaceDTO({
    required this.name,
    required this.address,
    required this.category,
    required this.coordi,
  });

  static PlaceDTO fromJson(Map<String, dynamic> j) {
    return PlaceDTO(
      name: j['place_name'],
      address: j['road_address_name'],
      category: j['category_group_name'],
      coordi: CoordiDTO(
        x: j['x'],
        y: j['y'],
      ),
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
}
