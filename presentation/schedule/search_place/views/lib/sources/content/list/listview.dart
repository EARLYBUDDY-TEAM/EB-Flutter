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
        Expanded(
          child: ListView(
            shrinkWrap: true,
            // controller: ModalScrollController.of(context),
            children: ListTile.divideTiles(
              context: context,
              tiles: tiles(places: places),
            ).toList(),
          ),
        ),
      ],
    );
    // return BlocSelector<SearchPlaceBloc, SearchPlaceState, List<Place>>(
    //   selector: (state) => state.places,
    //   builder: (context, places) {

    //   },
    // );
  }

  Iterable<Widget> tiles({
    required List<Place> places,
  }) {
    return List.generate(
      places.length,
      (index) => _SearchPlaceListItem(place: places[index]),
    );
  }
}
