import 'package:earlybuddy/domain/repository/searchplace/source/model/model.dart';
import 'package:flutter/widgets.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

final class EBKakaoMapView extends StatelessWidget {
  // final LatLng _center;
  // late KakaoMapController _mapController;
  // final List<Marker> _markers;

  // EBKakaoMap({
  //   super.key,
  //   required Place place,
  // }) : _center = LatLng(
  //         double.parse(place.coordi.y),
  //         double.parse(place.coordi.x),
  //       ),
  //       _markers = [Marker(markerId: markerId, latLng: latLng)]

  final Place place;
  late KakaoMapController _mapController;

  EBKakaoMapView({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return KakaoMap(
      center: _center(place),
      onMapCreated: ((controller) async {
        _mapController = controller;
      }),
      markers: [
        Marker(
          markerId: place.id,
          latLng: _center(place),
          infoWindowContent: '<div>${place.name}</div>',
          infoWindowFirstShow: true,
        )
      ],
    );
  }

  LatLng _center(Place place) {
    return LatLng(
      double.parse(place.coordi.y),
      double.parse(place.coordi.x),
    );
  }
}
