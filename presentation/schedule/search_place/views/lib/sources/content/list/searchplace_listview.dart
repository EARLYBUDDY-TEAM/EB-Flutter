part of '../../../eb_search_place.dart';

final class _SearchPlaceListView extends StatelessWidget {
  final List<Place> placeList;

  const _SearchPlaceListView({
    super.key,
    required this.placeList,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = ScreenSize.safeArea.bottom(context);
    return placeList.isNotEmpty
        ? _placeListView()
        : _emptyPlaceView(bottomPadding);
  }

  Widget _emptyPlaceView(double bottomPadding) {
    const color = Colors.grey;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 16,
            color: color,
            fontFamily: FontFamily.nanumSquareRegular,
          ),
          child: Column(
            children: [
              const Icon(
                CupertinoIcons.exclamationmark_circle,
                color: color,
                size: 40,
              ),
              const SizedBox(height: 10),
              const Text('검색 결과가 없어요.'),
              const SizedBox(height: 5),
              const Text('인터넷 연결을 확인해주세요.'),
              SizedBox(height: bottomPadding),
            ],
          ),
        ),
      ],
    );
  }

  Widget _placeListView() {
    return Column(
      children: [
        _divider(),
        _placeListContent(),
      ],
    );
  }

  Widget _placeListContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.separated(
          itemBuilder: (context, index) {
            final place = placeList[index];
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
          itemCount: placeList.length,
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      color: Colors.grey,
      thickness: 0.5,
    );
  }
}
