part of '../../../selectroute_view.dart';

final class SelectRouteListItem extends StatelessWidget {
  const SelectRouteListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _listItemRouteInfo(),
        _RouteLine(),
      ],
    );
  }

  Expanded _listItemRouteInfo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
        child: Row(
          children: [
            _ListItemRouteInfo(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
