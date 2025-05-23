part of '../../../eb_search_place.dart';

final class EBKakaoMapContent extends StatefulWidget {
  final Place place;

  const EBKakaoMapContent({
    required this.place,
  });

  @override
  State<StatefulWidget> createState() => _EBKakaoMapContentState();
}

final class _EBKakaoMapContentState extends State<EBKakaoMapContent> {
  late KakaoMapController _mapController;
  late Marker marker;
  Set<Marker> markers = {};
  late final LatLng _center = LatLng(
    double.parse(widget.place.coordi.y),
    double.parse(widget.place.coordi.x),
  );

  @override
  Widget build(BuildContext context) {
    return KakaoMap(
      center: _center,
      onMapCreated: ((controller) async {
        _mapController = controller;

        marker = Marker(
          markerId: widget.place.id,
          latLng: _center,
        );

        markers.add(marker);
        _mapController.addMarker(markers: markers.toList());
      }),
      onMarkerTap: (markerId, latLng, zoomLevel) {
        _mapController.panTo(latLng);
        setState(() {});
      },
      markers: markers.toList(),
    );
  }
}
