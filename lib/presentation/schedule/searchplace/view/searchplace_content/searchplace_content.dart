part of '../searchplace_view.dart';

final class _SearchPlaceContent extends StatelessWidget {
  final double searchBarHeight = 50;
  final double bottomSpace = 15;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) => Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: _SearchPlaceSwitchContent(
                  height:
                      constraints.maxHeight - (searchBarHeight + bottomSpace),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: _SearchBar(
                  searchBarHeight: searchBarHeight,
                  bottomSpace: bottomSpace,
                ),
              ),
            ],
          )),
    );
  }
}

final class _SearchPlaceSwitchContent extends StatelessWidget {
  final double height;

  const _SearchPlaceSwitchContent({
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: BlocBuilder<SearchPlaceBloc, SearchPlaceState>(
        builder: (context, state) {
          switch (state.status) {
            case ContentStatus.search:
              return _SearchPlaceListView(places: state.places);
            case ContentStatus.map:
              if (state.selectedPlace != null) {
                return EBKakaoMapView(place: state.selectedPlace!);
              } else {
                return const Text('Empty Data');
              }
          }
        },
      ),
    );
  }
}
