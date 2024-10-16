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
                final place = places[index];
                return _SearchPlaceListItem(
                  onTap: () => context
                      .read<SearchPlaceBloc>()
                      .add(PressListItem(place: place)),
                  place: place,
                );
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
}
