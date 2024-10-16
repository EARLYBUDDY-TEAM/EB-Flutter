part of '../../../eb_search_place.dart';

final class EBKakaoMapView extends StatelessWidget {
  final Place place;

  const EBKakaoMapView({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: constraints.maxHeight * 0.8,
                child: _EBKakaoMapContent(place: place),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: constraints.maxHeight * 0.2,
                child: _EBKakaoMapPlaceInfo(
                  place: place,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
