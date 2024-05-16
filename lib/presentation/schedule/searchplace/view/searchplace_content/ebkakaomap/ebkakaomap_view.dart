part of '../../searchplace_view.dart';

final class EBKakaoMapView extends StatelessWidget {
  final Place place;

  const EBKakaoMapView({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: _EBKakaoMapContent(place: place),
          ),
          Expanded(
            flex: 2,
            child: _EBKakaoMapPlaceInfo(place: place),
          ),
        ],
      ),
    );
  }
}
