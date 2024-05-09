part of '../searchplace_view.dart';

final class _SearchPlaceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        controller: ModalScrollController.of(context),
        children: ListTile.divideTiles(
          context: context,
          tiles: List.generate(
            100,
            (index) => _SearchPlaceListItem(),
          ),
        ).toList(),
      ),
    );
  }
}
