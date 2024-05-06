part of '../searchplace_view.dart';

final class _SearchPlaceContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SearchPlaceSearchBar(),
        _SearchPlaceListView(),
      ],
    );
  }
}
