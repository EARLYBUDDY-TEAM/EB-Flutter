part of '../../../eb_search_place.dart';

final class _SearchPlaceListView extends StatelessWidget {
  final List<Place> placeList;

  const _SearchPlaceListView({
    super.key,
    required this.placeList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _children,
    );
  }

  List<Widget> get _children {
    final List<Widget> listWidget =
        placeList.isNotEmpty ? [_divider(), _placeListView()] : [];
    return listWidget;
  }

  Widget _placeListView() {
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
