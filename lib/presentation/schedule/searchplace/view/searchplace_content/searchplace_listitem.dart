part of '../searchplace_view.dart';

final class _SearchPlaceListItem extends StatelessWidget {
  final Place place;

  const _SearchPlaceListItem({
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      title: Text(place.name),
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const KakaoMapView(),
        //   ),
        // );
      },
    );
  }
}
