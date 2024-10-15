part of '../../../eb_search_place.dart';

final class _SearchPlaceListView extends StatelessWidget {
  final List<Place> places;

  const _SearchPlaceListView({
    super.key,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _divider(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return _SearchPlaceListItem(place: places[index]);
              },
              separatorBuilder: (context, index) {
                return _divider();
              },
              itemCount: places.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return const Divider(
      color: Colors.grey,
      thickness: 0.5,
    );
  }

  // Iterable<Widget> tiles({
  //   required List<Place> places,
  // }) {
  //   return List.generate(
  //     places.length,
  //     (index) => _SearchPlaceListItem(place: places[index]),
  //   );
  // }
}
