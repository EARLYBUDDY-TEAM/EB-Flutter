part of '../../../eb_find_route.dart';

final class FindRouteKakaoMapView extends StatelessWidget {
  final String parentViewName;
  final String placeName;
  final Coordi coordi;

  const FindRouteKakaoMapView({
    super.key,
    required this.parentViewName,
    required this.placeName,
    required this.coordi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _FindRouteKakaoMapAppBar(
        parentViewName: parentViewName,
        placeName: placeName,
        backButtonAction: () => Navigator.of(context).pop(),
      ),
      body: FindRouteKakaoMapContent(coordi: coordi),
    );
  }
}

final class FindRouteKakaoMapContent extends StatefulWidget {
  final Coordi coordi;

  const FindRouteKakaoMapContent({
    super.key,
    required this.coordi,
  });

  @override
  State<StatefulWidget> createState() => _FindRouteKakaoMapContentState();
}

final class _FindRouteKakaoMapContentState
    extends State<FindRouteKakaoMapContent> {
  late KakaoMapController _mapController;
  late Marker marker;
  Set<Marker> markers = {};
  late final LatLng _center = LatLng(
    double.parse(widget.coordi.y),
    double.parse(widget.coordi.x),
  );

  @override
  Widget build(BuildContext context) {
    return KakaoMap(
      center: _center,
      onMapCreated: ((controller) async {
        _mapController = controller;

        marker = Marker(
          markerId: UniqueKey().toString(),
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

final class _FindRouteKakaoMapAppBar extends AppBar {
  final String parentViewName;
  final String placeName;
  final Function() backButtonAction;

  _FindRouteKakaoMapAppBar({
    required this.parentViewName,
    required this.placeName,
    required this.backButtonAction,
  });

  final Color color = EBColors.blue1;
  final String fontFamily = FontFamily.nanumSquareBold;
  final double fontSize = 17;

  @override
  Color? get backgroundColor => Colors.white;
  @override
  double? get scrolledUnderElevation => 0;
  @override
  bool get automaticallyImplyLeading => false;
  @override
  double? get leadingWidth => 150; // dynamic하게 적용법?

  @override
  Widget? get title => Text(
        placeName,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
      );

  @override
  Widget? get leading => NaviBackButton(
        parentViewName: parentViewName,
        onPressed: backButtonAction,
      );
}
