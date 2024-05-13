part of '../searchplace_view.dart';

final class _SearchPlaceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPlaceBloc, SearchPlaceState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchPlaceContentStatus.search:
            return Expanded(
              child: ListView(
                shrinkWrap: true,
                controller: ModalScrollController.of(context),
                children: ListTile.divideTiles(
                  context: context,
                  tiles: tiles(places: state.places),
                ).toList(),
              ),
            );
          case SearchPlaceContentStatus.map:
            if (state.selectedPlace != null) {
              return Expanded(
                child: EBKakaoMapView(place: state.selectedPlace!),
              );
            } else {
              return const Text('Empty Data');
            }
        }
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
