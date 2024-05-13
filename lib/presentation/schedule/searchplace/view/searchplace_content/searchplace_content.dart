part of '../searchplace_view.dart';

final class _SearchPlaceContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          _SearchPlaceSearchBar(),
          _SearchPlaceListView(),
        ],
      ),
    );
  }
}
