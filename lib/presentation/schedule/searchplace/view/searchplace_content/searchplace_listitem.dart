part of '../searchplace_view.dart';

final class _SearchPlaceListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('카카오지도'),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const KakaoMapView(),
          ),
        );
      },
    );
  }
}
