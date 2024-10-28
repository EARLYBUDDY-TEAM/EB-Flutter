part of '../../eb_search_place.dart';

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
        buildWhen: (previous, current) {
          final flag1 = (previous.placeList != current.placeList);
          final flag2 = (previous.contentStatus != current.contentStatus);
          return flag1 || flag2;
        },
        builder: (context, state) {
          final contentStatus = state.contentStatus;
          switch (contentStatus) {
            case ListSearchPlaceContent():
              return _SearchPlaceListView(
                placeList: state.placeList,
              );
            case MapSearchPlaceContent():
              return EBKakaoMapView(
                place: contentStatus.selectedPlace,
              );
          }
        },
      ),
    );
  }
}
