part of '../../searchplace_view.dart';

final class _SearchPlaceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPlaceBloc, SearchPlaceState>(
      builder: (context, state) {
        return Expanded(
          child: ListView(
            shrinkWrap: true,
            // controller: ModalScrollController.of(context),
            children: ListTile.divideTiles(
              context: context,
              tiles: tiles(places: state.places),
            ).toList(),
          ),
        );
      },
    );
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
