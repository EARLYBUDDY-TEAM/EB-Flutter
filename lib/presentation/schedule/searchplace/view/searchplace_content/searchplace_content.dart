part of '../searchplace_view.dart';

final class _SearchPlaceContent extends StatelessWidget {
  final double searchBarHeight = 50;
  final double bottomSpace = 15;

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     _SearchPlaceSearchBar(),
    //     _SearchPlaceSwitchContent(),
    //   ],
    // );
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
                child: _SearchPlaceSearchBar(
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
            case SearchPlaceContentStatus.search:
              return _SearchPlaceListView();
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
      ),
    );
  }
}
